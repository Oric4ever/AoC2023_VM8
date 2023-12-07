# AoC2023_VM8

Here is an attempt to solve the 2023 edition of the Advent of Code on my VM8 system:
the VM8 is an 8-bit system with 64 Kbytes of ram, running its own development tools (ie. a simple disk operating system, an editor and a compiler).

The system's performance is lower than the one of dedicated systems: because the processor (ATmega162) has an Harvard architecture, it cannot run native code from ram so actually it spends all its time interpreting the bytecodes produced by the Oberon compiler.
But then this means that the system is able to dynamically load any program and interpret it from the ram.

To give an idea of the performance, the calculation of fibonacci(42) using the following function takes **4 hours 44 minutes 52 seconds**.

```pascal
PROCEDURE fibonacci(n: INTEGER):LONGINT;
  VAR result: LONGINT;
BEGIN
  IF n < 2
  THEN result := LONG(n)
  ELSE result := fibonacci(n-1) + fibonacci(n-2)
  END;
  RETURN result
END fibonacci;
```

This means that the Advent of Code puzzles have to be solved with algorithms that avoid brute force approaches...

I've also noticed that more and more puzzles of the Advent of Code requires 64-bits integers... It's a bit of problem with my Oberon implementation where INTEGERs are 16 bits, and LONGINTs are 32 bits, so I have to use a library of multi-precision numbers...
