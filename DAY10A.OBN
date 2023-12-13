MODULE Day10a;
IMPORT In, Out, Strings;
CONST Size = 140;
      EOL = 0AX;
VAR map : ARRAY Size,Size+2 OF CHAR;
    startX, startY: INTEGER;

PROCEDURE ReadMap;
VAR y, x: INTEGER;
BEGIN
  FOR y := 0 TO Size-1 DO
    In.Line(map[y]);
    FOR x := 0 TO Size-1 DO
      IF map[y][x] = "S" THEN startX := x; startY := y END;
    END;
  END;
END ReadMap;

PROCEDURE Swap(VAR a,b: INTEGER);
VAR tmp : INTEGER;
BEGIN
  tmp := a; a := b; b := tmp
END Swap;

PROCEDURE FollowLoop;
VAR x,y,dx,dy, length : INTEGER;
    ch : CHAR;
BEGIN
  length := 0; y := startY; x := startX; dx := 0; dy := -1;
  REPEAT
    x := x + dx; y := y + dy;
    INC(length);
    ch := map[y][x];
    CASE ch OF
    | "|": dx := dx; dy := dy
    | "-": dx := dx; dy := dy
    | "L": Swap(dx, dy)
    | "7": Swap(dx, dy)
    | "F": Swap(dx, dy); dx := -dx; dy := -dy 
    | "J": Swap(dx, dy); dx := -dx; dy := -dy 
    END;
  UNTIL ch = "S";
  Out.Int(length DIV 2, 1); Out.Ln;
END FollowLoop;

BEGIN
  ReadMap;
  FollowLoop
END Day10a.
