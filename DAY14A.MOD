MODULE Day14a;
IMPORT In, Out, Strings;
CONST Size = 100;
VAR map : ARRAY Size,Size+2 OF CHAR;

PROCEDURE ReadMap;
VAR y, x: INTEGER;
    ch : CHAR;
BEGIN
  FOR y := 0 TO Size-1 DO In.Line(map[y]) END;
END ReadMap;

PROCEDURE Tilt;
VAR i, x, y: INTEGER;
    sum : LONGINT;
BEGIN
  FOR i := 1 TO Size DO
    FOR y := 1 TO Size-1 DO
      FOR x := 0 TO Size-1 DO
        IF (map[y][x] = "O") & (map[y-1][x] = ".") THEN map[y-1][x] := "O"; map[y][x] := "." END;
      END;
    END;
  END;

  sum := LONG(0);
  FOR y := 0 TO Size-1 DO
    FOR x := 0 TO Size-1 DO
      IF map[y][x] = "O" THEN sum := sum + LONG(Size - y) END;
    END;
  END;

  Out.Long(sum, 1); Out.Ln;
END Tilt;

BEGIN
  ReadMap;
  Tilt
END Day14a.
