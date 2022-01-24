# Welcome to cs655 (Spring-2022)
### Seyedamirhossein Hesamian (Amir)
- Please send email questions to:
  - [boyland@uwm.edu](mailto:boyland@uwm.edu)
  - [hesamian@uwm.edu](mailto:hesamian@uwm.edu)
- Office hour: Tuesday, Wednesday, Thursday via Zoom
- Room: Zoom
- Slides: [github.com/amir734jj/cs655-lecture-notes](https://github.com/amir734jj/cs655-lecture-notes)

---

## Greetings :)

- Bachelor, masters, or PhD student?
- Favorite programming language? and why?
- Fun software project you worked on?

---

## Pos and cons of taking compiler class:

- 2 minutes rant ...

---

## Undergraduate
- 30% Laboratory Assignments
- 70% Programming Assignments

## Graduate
- 15% Laboratory Assignments
- **15% Term Paper**
- 70% Programming Assignments

---

## Compiler Steps (according to textbook)

- Front-end:
  - Lexical analysis: Tokenizing
  - Syntax analysis: Parsing
  - Semantic analysis
    - Name resolution, binding, type-checking
    - Optimize AST
    - Intermediate code generation
- Back-end
  - Code generation
    - Machine independent code generation
    - Target code generation
    - Machine specific code generation

---


# Compiler Steps in Action

```xml
1 + 2 >--(Tokenizer)--> <Num, 1> <PlusToken> <Num, 2>

>--(Parser)-->
                          <Root>
                             |
                        <PlusToken> 
                        /         \
                  <Num, 1>        <Num, 2>
>--(Semantic)-->
    Type of <PlusToken>? Int. Because Int + Int = Int
    Type of <Root>? Int. Because Int = Int

>--(CodeGen)-->
  int result = 1 + 2;
```

---


# Essential Concepts

- AST
- BNF / E-BNF (Option, Repetition, Grouping, Concatenation) 
- Visitor pattern

---

# Reading Recommendations

- Cool manual: read this thoroughly, please!
- Textbook: Michael Scott. Programming Language Pragmatics.
- Optional textbook: "Dragon Book"

---

# Cool
## Subset of Scala

Cool or "Classroom Object Oriented Language" is a:
- static (not dynamic): types are determined at the compile-time as oppose to run-time
- strong (not weak): there *are* restrictions for type conversions
- manifest (not inferred): variable types are explicitly defined as oppose to implicit

---

# Cool (Cont.)
## More about "static" aspect.

Types are defined (or deduced) in AST (or Abstract Syntax Tree) before code is generated. In dynamic languages like Python, JavaScript types are derived at the run-time hence, REPL (or Read–Eval–Print-Loop).

---

# Cool (Cont.)
## More about "strong" aspect.

There is no pointer in Cool but we have reference type variables (Any, ArrayAny and etc.). All types extend `Any` (actually `Any` extends `Nothing` but that is a special type). Moreover, we can only extend one type in Cool unlike C++ multiple inheritance is not allowed.


---

# Cool (Cont.)
## More about pattern matching

Cool is strongly typed because we can only type convert between types that are possible. For example, in the following we should **not** be able to do pattern matching from `C` to `String` (in one step):

```
Nothing -> Any -> | A -> B -> C
                  | String
                  | ArrayAny
```

Exercise: How to break this type system restriction?
<!--- Solution: use multi-step pattern matching. -->

--- 

### Solution:

`C` to `Any` and then `Any` to `String` (multi-step)

---

# Cool (Cont.)
## More about manifest.

Unlike Scala which is a super-set of Cool, we have be explicit about types. Scala comes with "duck" typing.

```scala
var i : Int = 234; 
```

--- 

### Cool syntax vs Java (part #1)
 
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World");
    }
}
```

```scala
// We need to extend IO to be able to use `out`
class Main() extends IO() {
   // This is a expression "block"
   // All block expressions that are "feature" (or root level) 
   // run after primary constructor is invoked
   {
      out("Hello, World");
   }
}
```

---

### Cool syntax vs Java (part #2)

```java
public class HelloWorld {
    public static int factorial(int n) {
        return n == 0 ? 1 : n * factorial(n - 1);
    }

    public static void main(String[] args) {
        System.out.println("result: " + factorial(10));
    }
}
```

```scala
class Main() extends IO() {
    // self keyword is similar to `this`, it's a way to
    // access class scope
    // == is a syntax sugar for .equals() of Int which
    // is an object
    def factorial(n : Int) = if (n == 0) 1 else self.factorial(n - 1);
    {
      // Notice how there is no implicit conversion from Int to String unlike java
      out("result: ".concat(factorial(10).toString()));
    }
}
```
---

### Cool syntax vs Java (part #3)

```java
public class HelloWorld {
    public static void main(String[] args) {
      int[] arr = new int[] { 4, 5, 9 };
      System.out.println(arr[0] + arr[1] == arr[2]);
    }
}
```

```scala
class Main() extends IO() {
    {
      var arr: ArrayAny = new ArrayAny(3);
      arr.set(0, 4);
      arr.set(1, 5);
      arr.set(2, 9);

      var x: Int = arr.get(0) match { case num: Int => num };
      var y: Int = arr.get(1) match { case num: Int => num };
      var z: Int = arr.get(2) match { case num: Int => num };
      out(
        (x + y == z).toString()
      )
    }
}
```

---

# Lab Exercise

- Implement `Vector` and `VectorEnumeration`
- Assignment #1 is already posted

--- 

# Vector

In Java, `vector` is very similar to `ArrayList` in Java but not thread-safe and resizes by doubling the size as oppose to increase the size by half.

- Vector
  - `size(): Int`
  - `add(Any): Unit`
  - `clear(): Unit`
  - `elements(): Enumeration` (i.e. return `VectorEnumeration`)

- Enumeration:
  - `next(): Any`
  - `hasNext(): Boolean`

---

# Concerning `IO`

We will be using:
- `abort(): Nothing` // halts the program

---

# Concerning `ArrayAny`

We will be using:
- `new ArrayAny(Int)`: constructor
- `.get(Int):Any`: get array at index
- `.set(Int, Any):Any`: set array at index and returns old value
- `.resize(Int):ArrayAny`: resizes the array

---

# TODO

```scala
class Enumeration() extends IO() {
  // TODO
}
class Vector() {
  // TODO
}
class VectorEnumeration(var elements: ArrayAny, var n: Int) extends Enumeration() {
  // TODO
}
```
