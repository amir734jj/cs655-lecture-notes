```
// First of epsilon is epsilon
First(epsilon) = { epsilon }

// First of a terminal|any is that terminal
First(xB) = { x }

// First of non-terminal|non-terminal is
//      first(non-terminal) dot first(non-terminal)
First(NB) = First(N) \dot First(B)

// First non-terminal is first of RHS
First(N) = { N -> a | First(a) } 
```