# Constant folding

Compiler optimization and exercise of AST modification

---

# Notes

- The idea is trying to evaluate constant expressions in a compile-time as oppose to run-time **when** we have all things we need to evaluate it.

- For example given `var i : Int = 3 * 4 + 2;`. We should be able to replace `i`'s RHS expression with "14". 

- Remember AST is immutable so we need to return a new AST

---

# How to accomplish it?

Using visistor pattern and modifying the AST by returning a updated node

---

# Lab assignment

We are trying to use a inherited and synthesized attribute to achieve this.
