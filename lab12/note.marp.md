---
marp: true
---

# Optimize code generation

---

### Three improvements to assignment #7

- no more boxing and unboxing for boolean
- no more boxing and unboxing for integer
    - this means that when expression returns a boolean or integer, it's just the value and now unlike assignment 7 we don't need to try to get the value from an object. The value in register `a0` is the final value.
- using `s1 ... s6` as temporaries
    this means that we need to cycle through temporaries and if current temporaries exceed the available temporary registers, then
    we need to spill/un-pill.

---

# Lab assignment

In this lab assignment we wil compare the generated MIPS code with/without optimization flag on.