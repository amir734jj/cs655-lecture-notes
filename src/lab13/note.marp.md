# Temporary calculations

The goal of this lab is to implement temporary calculations for a `Cmethod` body that you will need for PA7.

The trick is to implement these temporary calculations as recursive functions that takes as parameter current number of temporaries and AST node and in the body of this function it recursively calls itself with its child ASTs. The highest value of parameter for temporaries is the number of temporaries that we need to allocate for this method.

For example:

```scala
// number of temporaries for a method start from 0
var max_temporaries: Int = 0;

def calc(a: Cadd, current_temporaries: Int): Unit = {
  // update max_temporaries
  if (current_temporaries > max_temporaries)
    max_temporaries = current_temporaries
  else
    ();

  calc(a.get_e1(), current_temporaries)

  // we need one extra temporaries to
  // temporary hold the result of e1 expression
  calc(a.get_e2(), current_temporaries + 1);

  // nothing to return
  ()
}
```

