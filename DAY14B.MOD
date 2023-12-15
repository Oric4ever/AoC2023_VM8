MODULE Day14b;
IMPORT In, Out, Strings;
CONST Size = 100;
VAR map, save : ARRAY Size,Size+2 OF CHAR;

PROCEDURE ReadMap;
VAR y, x: INTEGER;
    ch : CHAR;
BEGIN
  FOR y := 0 TO Size-1 DO In.Line(map[y]) END;
END ReadMap;

PROCEDURE TiltNorth;
VAR x, y, n, base, count  : INTEGER;
BEGIN
  FOR x := 0 TO Size-1 DO
    y := 0;
    WHILE y < Size DO
      base  := y-1;
      count := 0;
      WHILE (y < Size) & (map[y][x] # "#") DO
        IF map[y][x] = "O" THEN INC(count); map[y][x] := "." END;
        INC(y)
      END;
      FOR n := 1 TO count DO map[base+n][x] := "O" END;
      WHILE (y < Size) & (map[y][x] = "#") DO INC(y) END;
    END;
  END;
END TiltNorth;

PROCEDURE TiltEast;
VAR x, y, n, base, count  : INTEGER;
BEGIN
  FOR y := 0 TO Size-1 DO
    x := Size-1;
    WHILE x >= 0 DO
      base  := x+1;
      count := 0;
      WHILE (x >= 0) & (map[y][x] # "#") DO
        IF map[y][x] = "O" THEN INC(count); map[y][x] := "." END;
        DEC(x)
      END;
      FOR n := 1 TO count DO map[y][base-n] := "O" END;
      WHILE (x >= 0) & (map[y][x] = "#") DO DEC(x) END;
    END;
  END;
END TiltEast;

PROCEDURE TiltSouth;
VAR x, y, n, base, count  : INTEGER;
BEGIN
  FOR x := 0 TO Size-1 DO
    y := Size-1;
    WHILE y >= 0 DO
      base  := y+1;
      count := 0;
      WHILE (y >= 0) & (map[y][x] # "#") DO
        IF map[y][x] = "O" THEN INC(count); map[y][x] := "." END;
        DEC(y)
      END;
      FOR n := 1 TO count DO map[base-n][x] := "O" END;
      WHILE (y >= 0) & (map[y][x] = "#") DO DEC(y) END;
    END;
  END;
END TiltSouth;

PROCEDURE TiltWest;
VAR x, y, n, base, count  : INTEGER;
BEGIN
  FOR y := 0 TO Size-1 DO
    x := 0;
    WHILE x < Size DO
      base  := x-1;
      count := 0;
      WHILE (x < Size) & (map[y][x] # "#") DO
        IF map[y][x] = "O" THEN INC(count); map[y][x] := "." END;
        INC(x)
      END;
      FOR n := 1 TO count DO map[y][base+n] := "O" END;
      WHILE (x < Size) & (map[y][x] = "#") DO INC(x) END;
    END;
  END;
END TiltWest;

PROCEDURE Cycle;
BEGIN
  TiltNorth;
  TiltWest;
  TiltSouth;
  TiltEast;
END Cycle;

PROCEDURE Cycles;
CONST FirstCycles = 125; (* approximative number of first cycles obtained on the PC *)
VAR n, y, period, remaining: INTEGER;
    equal: BOOLEAN;
BEGIN
  FOR n := 1 TO FirstCycles DO Cycle; Out.Char(".") END;
  Out.Ln;
  
  save := map;

  period := 0;
  REPEAT
    INC(period);
    Cycle;
    equal := TRUE;
    FOR y := 0 TO Size-1 DO
      IF map[y] # save[y] THEN equal := FALSE END;
    END;
  UNTIL equal;

  remaining := INT( (LONG(31250)*LONG(32000) - LONG(FirstCycles) - LONG(period)) MOD LONG(period) );
  FOR n := 1 TO remaining DO Cycle END;
END Cycles;

PROCEDURE Weight;
VAR x, y: INTEGER;
    sum : LONGINT;
BEGIN
  sum := LONG(0);
  FOR y := 0 TO Size-1 DO
    FOR x := 0 TO Size-1 DO
      IF map[y][x] = "O" THEN sum := sum + LONG(Size - y) END;
    END;
  END;
  Out.Long(sum, 1); Out.Ln;
END Weight;

BEGIN
  ReadMap;
  Cycles;
  Weight
END Day14b.
