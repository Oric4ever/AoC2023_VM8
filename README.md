# AoC2023_VM8

Here is an attempt to solve the 2023 edition of the Advent of Code on my VM8 system:
the VM8 is an 8-bit system with 64 Kbytes of ram, running its own development tools (ie. a simple disk operating system, an editor and a compiler).
file:///home/fabrice/Images/micro/20231207_114858.jpg![image](https://github.com/Oric4ever/AoC2023_VM8/assets/42356653/592e8937-0359-4889-878d-0753d550bcc8)


The system's performance is lower than the one of dedicated systems: because the processor (ATmega162) has an Harvard architecture, it cannot run native code from ram so actually it spends all its time interpreting the bytecodes produced by my Oberon compiler.
But then this means that the system is able to dynamically load any program and interpret it from the ram.

To give an idea of the computation performance, the calculation of **fibonacci(42)** using the following function takes **4 hours 44 minutes 52 seconds**.

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
