---
marp: true
---

# AST

Abstract syntax tree (AST), or just syntax tree, is a tree representation of the abstract syntactic structure of source code written in a programming language. 

---

# Example of AST (#1)

- Given the following expression:
```javascript
1 + 2
```

--- 

- The output AST would be:

```text
+ BinaryExpression
 - type: +
 - left_value: 
  LiteralExpr:
   value: 1
 - right_value:
  LiteralExpr:
   value: 2
```

---

# Example of AST (#2)


 - Given the following expression:
```javascript
if (2 > 6) {
    var d  = 90
    console.log(d)
}
```

---

 The output AST would be:
```text
IfStatement
 - condition
  + BinaryExpression
   - type: >
   - left_value: 2
   - right_value: 6
 - body
  [
    - Assign
        - left: 'd';
        - right: 
            LiteralExpr:
            - value: 90
    - MethodCall:
         - instanceName: console
         - methodName: log
         - args: [
         ]
  ]
```

---

# Lab assignmnet

Follow "Cool Tour" to construct "Queens.cool" given it's AST. Basically reverse engineer the cool program from its AST.

---

# 

