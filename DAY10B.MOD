MODULE Day10b;
IMPORT In, Out, Strings;
CONST Size = 140;
      EOL = 0AX;
VAR map : ARRAY Size,Size+2 OF CHAR;
    borders: ARRAY Size, Size+1 OF BOOLEAN;
    startX, startY: INTEGER;

PROCEDURE ConnectUp   (ch: CHAR):BOOLEAN; BEGIN RETURN (ch = "|") OR (ch = "J") OR (ch = "L") END ConnectUp;
PROCEDURE ConnectDown (ch: CHAR):BOOLEAN; BEGIN RETURN (ch = "|") OR (ch = "7") OR (ch = "F") END ConnectDown;
PROCEDURE ConnectLeft (ch: CHAR):BOOLEAN; BEGIN RETURN (ch = "-") OR (ch = "7") OR (ch = "J") END ConnectLeft;
PROCEDURE ConnectRight(ch: CHAR):BOOLEAN; BEGIN RETURN (ch = "-") OR (ch = "F") OR (ch = "L") END ConnectRight;

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
    ch := map[y][x]; borders[y][x] := TRUE;
    CASE ch OF
    | "|": dx := dx; dy := dy
    | "-": dx := dx; dy := dy
    | "L": Swap(dx, dy)
    | "7": Swap(dx, dy)
    | "F": Swap(dx, dy); dx := -dx; dy := -dy
    | "J": Swap(dx, dy); dx := -dx; dy := -dy
    END;
  UNTIL ch = "S";
END FollowLoop;

PROCEDURE Surface;
VAR x,y,area: INTEGER;
    inside : BOOLEAN;
    ch, first: CHAR;
BEGIN
  (* replace the starting S in order to form a real loop and eliminate cornercases *)
  IF      ConnectUp   (map[startY+1][startX  ]) THEN
    IF    ConnectDown (map[startY-1][startX  ]) THEN map[startY][startX] := "|"
    ELSIF ConnectRight(map[startY  ][startX-1]) THEN map[startY][startX] := "7"
    ELSE
      ASSERT( ConnectLeft(map[startY][startX+1]) );  map[startY][startX] := "F"
    END;
  ELSIF   ConnectDown (map[startY-1][startX  ]) THEN
    IF    ConnectLeft (map[startY  ][startX+1]) THEN map[startY][startX] := "L"
    ELSE
      ASSERT( ConnectRight(map[startY][startX-1]) ); map[startY][startX] := "J"
    END;
  ELSE
      ASSERT( ConnectLeft (map[startY][startX+1]) );
      ASSERT( ConnectRight(map[startY][startX+1]) ); map[startY][startX] := "-"
  END;

  area := 0;
  FOR y := 0 TO Size-1 DO
    inside := FALSE;
    FOR x := 0 TO Size DO
      IF borders[y][x] THEN
        ch := map[y][x];
        CASE ch OF
        | "|" : inside := NOT inside
        | "L" : first  := ch
        | "F" : first  := ch
        | "7" : IF first = "L" THEN inside := NOT inside END;
        | "J" : IF first = "F" THEN inside := NOT inside END;
        END;
      ELSIF inside THEN INC(area)
      END;
    END;
  END;
  Out.Int(area, 1); Out.Ln
END Surface;

BEGIN
  ReadMap;
  FollowLoop;
  Surface
END Day10b.
