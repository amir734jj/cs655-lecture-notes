# MIPS Code-Gen Data Segment

In this lab we will be discussing MIPS code generation, more specifically data segment. Basically everything that needs to be done for PA6. You are given the expected file, notice that it contains the prologue, epilogue and object header twice, one with garbage collection flag as `true` and another with `gc=false`.

After you are done with this lab, you now have the prologue and epilogue done. You now also have the object header which can be used for object prototype generation and literal objects (i.e. string, int, bool, unit) used throughout the COOL program.

Another objective of this lab is learning how the `Emitter` class works.