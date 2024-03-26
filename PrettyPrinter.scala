object Main {
  def main(args: Array[String]) = {
    var parser = new CoolTreeParser();
    parser.start()

    var program = parser.parse_Program(0);
    parser.resolve_attributes()
    
    new PrettyPrinter(program).run()
  }
}

class PrettyPrinter(var program: Program) extends CoolTreeVisitor() {
  private val nativeClasses = List("Any", "IO", "Unit", "Int", "Boolean", "String", "Symbol", "ArrayAny", "Statistics")

  private var sb = new StringBuilder()
  private var lv = 0

  private def indent() = " " * lv * 2

  private def strify(s: Symbol) = {
    val keyValPattern = "Symbol\\(([^)]+)\\)".r
    val source = s.toString();

    val result = keyValPattern.findFirstMatchIn(source) match {
      case Some(v) => v.group(1)
      case none    => source.drop(1)
    };

    result
  };

  private def dump_string(s: String): String = {
    val b: StringBuilder = new StringBuilder()

    for (c <- s) {
      b.append(c match {
        case '\r' => "\\r"
        case '\n' => "\\n"
        case '\t' => "\\t"
        case '\\' => "\\\\"
        case _    => c
      })
    }

    return b.toString
  }

  private def unary(e1: Expression, op: String) = {
    sb ++= op
    e1.accept(this)
  }

  private def binary(e1: Expression, e2: Expression, op: String) = {
    e1.accept(this)
    sb ++= " " + op + " "
    e2.accept(this)
  }

  def run() = {
    program.accept(this)
    print(sb)
  }

  override def visit_program(node: Cprogram, classes: Classes) = {
    classes.accept(this)
  }

  var constructor_pieces : ExpressionsEnumeration = null;

  override def visit_class_decl(node: Cclass_decl, name: Symbol, parent: Symbol, features: Features, filename: Symbol) = {
    // do not print native classes
    if (!nativeClasses.contains(strify(name))) {
      // deconstruct features into attributes and methods
      // they are unordered in the list, but we want to print
      // attributes first

      var attrs = List[Cattr]()
      var meths = List[Cmethod]()

      val e = features.elements()
      while (e.hasNext()) {
        e.next() match {
          case a: Cattr   => attrs = attrs :+ a
          case m: Cmethod => meths = meths :+ m
        }
      }

      // remove constructor
      val constr : Cmethod = meths.head;
      meths = meths.tail

      val cformals = constr.get_formals().elements();
      constructor_pieces = constr.get_expr() match {
	case b:Cblock => b.get_body().elements()
      };

      // print header
      sb ++= "class " + strify(name) + "(";
      while (cformals.hasNext()) {
	val attr = attrs.head; attrs = attrs.tail;
	sb ++= "var " + strify(attr.get_name()) + ": " + strify(attr.get_of_type());
	cformals.next();
	constructor_pieces.next();
        if (cformals.hasNext()) sb ++= ", ";
      }
      sb ++= ")";

      // print extends if not the default extends
      val superArgs = constructor_pieces.next() match {
	case sd:Cstatic_dispatch => sd.get_actuals().elements()
      };
      if (strify(parent) != "Any") {
        sb ++= " extends " + strify(parent) + "(";
	while (superArgs.hasNext()) {
	  superArgs.next().accept(this);
	  if (superArgs.hasNext()) {
	    sb ++= ", ";
	  }
	};
	sb ++= ")"
      }

      sb ++= " {\n"
      lv = lv + 1;
      var needSpace : Boolean = false;

      // print attributes
      for (a <- attrs) {
	a.accept(this);
	needSpace = true;
      }

      // now print initialization blocks
      while (constructor_pieces.hasNext()) {
	constructor_pieces.next() match {
	  case b:Cblock =>
	    if (needSpace) {
	      sb ++ "\n";
	    }
	    sb ++= indent();
	    b.accept(this);
	    sb ++= ";\n";
	    needSpace = true
	  case v:Cvariable =>
	    {}
	}
      }

      // separate attributes and methods by newline
      if (needSpace && meths.size > 0) sb ++= "\n"

      // print methods
      for (m <- meths) m.accept(this)

      lv = lv - 1
      sb ++= "}\n\n"
    }
  }

  override def visit_attr(node: Cattr, name: Symbol, of_type: Symbol) = {
    sb ++= indent()
    sb ++= "var " + strify(name) + ": " + strify(of_type);
    constructor_pieces.next() match {
      case a:Cassign => 
	sb ++= " = ";
        a.get_expr().accept(this)
    }
    sb ++= ";\n"
  }

  override def visit_method(node: Cmethod, overridep: Boolean, name: Symbol, formals: Formals, return_type: Symbol, expr: Expression) = {
    sb ++= indent()
    if (overridep) {
      sb ++= "override "
    }

    sb ++= "def " + strify(name) + "("
    visit_formals(formals)
    sb ++= "): " + strify(return_type) + " = "
    
    expr.accept(this)

    sb ++= ";\n\n"
  }

  def visit_formals(formals: Formals) = {
    val e = formals.elements()
    if (e.hasNext()) {
      while (e.hasNext()) {
        e.next().accept(this)
        sb ++= ", "
      }

      sb = sb.dropRight(2)
    }
  }

  override def visit_formal(node: Cformal, name: Symbol, of_type: Symbol) = {
    sb ++= strify(name) + ": " + strify(of_type) // ##
    // TODO
  }

  override def visit_let(node: Clet, identifier: Symbol, local_type: Symbol, init: Expression, body: Expression) = {
    // #(
    sb ++= "var " + strify(identifier) + ": " + strify(local_type) + " = "
    init.accept(this)
    sb ++= ";\n"
    sb ++= indent()
    body.accept(this)
    // #)
    // TODO
  }

  override def visit_assign(node: Cassign, name: Symbol, expr: Expression) = {
    // #(
    sb ++= strify(name) + " = "
    expr.accept(this)
    // #)
    // TODO
  }

  override def visit_static_dispatch(node: Cstatic_dispatch, expr: Expression, type_name: Symbol, name: Symbol, actuals: Expressions) = {
    // #(
    expr.accept(this)
    sb ++= "." + strify(name) + "("

    val e = actuals.elements()
    if (e.hasNext()) {
      while (e.hasNext()) {
        e.next().accept(this)
        sb ++= ", "
      }

      sb = sb.dropRight(2)
    }

    sb ++= ")"
    // #)
    // TODO
  }

  override def visit_dispatch(node: Cdispatch, expr: Expression, name: Symbol, actuals: Expressions) = {
    // #(
    expr.accept(this)
    sb ++= "." + strify(name) + "("

    val e = actuals.elements()
    if (e.hasNext()) {
      while (e.hasNext()) {
        e.next().accept(this)
        sb ++= ", "
      }

      sb = sb.dropRight(2)
    }

    sb ++= ")"
    // #)
    // TODO
  }

  override def visit_cond(node: Ccond, pred: Expression, then_exp: Expression, else_exp: Expression) = {
    // #(
    sb ++= "if ("
    pred.accept(this)
    sb ++= ") "
    then_exp.accept(this)
    sb ++= " else "
    else_exp.accept(this)
    // #)
    // TODO
  }

  override def visit_loop(node: Cloop, pred: Expression, body: Expression) = {
    // #(
    sb ++= "while ("
    pred.accept(this)
    sb ++= ") "
    body.accept(this)
    // #)
    // TODO
  }

  override def visit_typecase(node: Ctypecase, expr: Expression, cases: Cases) = {
    // #(
    expr.accept(this)
    sb ++= " match {\n"

    val e = cases.elements()
    if (e.hasNext()) {
      lv = lv + 1
      while (e.hasNext()) {
        sb ++= indent()
        e.next().accept(this)
        sb ++= "\n"
      }

      lv = lv - 1
    }

    sb ++= indent()
    sb ++= "}"
    // #)
    // TODO
  }

  override def visit_branch(node: Cbranch, name: Symbol, local_type: Symbol, expr: Expression) = {
    // #(
    sb ++= "case " + strify(name) + ": " + strify(local_type) + " => "
    expr.accept(this)
    // #)
    // TODO
  }

  override def visit_block(node: Cblock, body: Expressions) = {
    // #(
    if (body.size() == 0) {
      sb ++= "{}";
    } else {
      sb ++= "{\n"

      val e = body.elements()
      if (e.hasNext()) {
	while (e.hasNext()) {
          lv = lv + 1
          sb ++= indent()
          e.next().accept(this)
          lv = lv - 1
	  
          sb ++= ";\n"
	}
    
	sb = sb.dropRight(2)
      }
      
      sb ++= "\n"
      sb ++= indent()
      sb ++= "}"
    }
    // #)
    // TODO
  }

  override def visit_neg (node: Cneg,  e1: Expression) = unary(e1, "-")
  // #(
  override def visit_comp(node: Ccomp, e1: Expression) = unary(e1, "!")

  override def visit_add(node: Cadd, e1: Expression, e2: Expression) = binary(e1, e2, "+")
  override def visit_sub(node: Csub, e1: Expression, e2: Expression) = binary(e1, e2, "-")
  override def visit_mul(node: Cmul, e1: Expression, e2: Expression) = binary(e1, e2, "*")
  override def visit_div(node: Cdiv, e1: Expression, e2: Expression) = binary(e1, e2, "/")
  override def visit_lt (node: Clt,  e1: Expression, e2: Expression) = binary(e1, e2, "<")
  override def visit_leq(node: Cleq, e1: Expression, e2: Expression) = binary(e1, e2, "<=")
  // #)
  // TODO override rest of unary and binary operators with onliners.

  override def visit_variable(node: Cvariable, name: Symbol) = {
    sb ++= strify(name); // ##
    // TODO
  }

  override def visit_alloc(node: Calloc, type_name: Symbol) = {
    sb ++= "new " + strify(type_name) // ##
    // TODO
  }

  override def visit_no_expr(node: Cno_expr) = {
    sb ++= "/* empty expression */"
  }

  override def visit_int_lit(node: Cint_lit, token: Symbol) = {
    sb ++= strify(token) // ##
    // TODO
  }

  override def visit_bool_lit(node: Cbool_lit, value: Boolean) = {
    // #(
    if (value) {
      sb ++= "true"
    } else {
      sb ++= "false"
    }
    // #)
    // TODO
  }

  override def visit_string_lit(node: Cstring_lit, token: Symbol) = {
    // #(
    sb ++= '"' + dump_string(strify(token)) + '"'
    // #)
    // TODO
  }

  override def visit_nil(node: Cnil) = {
    sb ++= "null" // ##
    // TODO
  }

  override def visit_unit(node: Cunit) = {
    sb ++= "()" // ##
    // TODO
  }
}
