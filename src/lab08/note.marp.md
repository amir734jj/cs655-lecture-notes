# Inheritance graph


In this lab we want to record the class inheritance relationship, or when one class extends another class.

```scala
class Bar() extends Foo() { }

class Baz() extends Foo() { }
```

---

# Naive approach

Use a map where key is `Bar`, `Baz` and value is `Foo`

```scala
// child as key
// parent as value
var table: Map[Symbol, Symbol] = Map()

override def visit_class_decl(cd: Cclass_decl,
                              child: Symbol,
                              parent: Symbol,
                              features: Features,
                              filename: Symbol) {

    // Add a key value pair to the map
    table += (child -> parent)
}
```

To get classes that extend class `Foo`, i.e. `Bar` & `Baz` we need to invert the map

```scala
// collect direct children
var inverted = table
  .groupBy(_._2)
  .map(x => x._1 -> x._2.keys.toSet)
  .toMap

// now inverted holds a dictionary where key=parent and value=children

// transitive closure to collect indirect children
for (_ <- 1 to inverted.size) {
  for ((parent, children) <- inverted) {
    for (child <- children) {
      inverted += (parent -> (inverted(parent) ++ inverted.getOrElse(
        child,
        Set()
      )))
    }
  }
}
```

--- 

# How to use tables

- To get class that `Bar` extends: `table.getOrElse('Bar, 'Any)`
- To get classes that extend `Foo`: `inverted.getOrElse('Foo, List())`


# How case works in the code generation

```scala
Note:
    (pre-order number, max pre-order number)
    
Cool:

    Any (1,7)
     |              |                     |
    Int (2,2)    String (3,3)           IO (4,7)
                                      /             \
                                 ArrayAny (5,5)    Foo (6,7)
                                                    |
                                                   Bar (7,7)
 
 
def foo(x : Any) : Any = x match {
// if (X >= 7 && X <= 7)
  case t : Bar =>
  
// if (X >= 6 && X <= 7)
  case a : Foo =>

// if (X >= 2 && X <= 2)
  case i : Int =>

// if (X == 0)
  case null =>

// if (X >= 1 && X <= 7)
  case a : Any =>
}
```

