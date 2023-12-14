MODULE Day13b;
IMPORT In, Out, Strings, Streams;
CONST Size = 100;
      EOL = 0AX;
VAR map : ARRAY Size,Size OF CHAR;
    width, height: INTEGER;

PROCEDURE VerticalDiffs(x: INTEGER): INTEGER;
VAR y, dx, diffCount: INTEGER;
BEGIN
  diffCount := 0;
  dx := 1;
  REPEAT
    FOR y := 0 TO height-1 DO
      IF map[y][x-dx] # map[y][x+dx-1] THEN INC(diffCount) END;
    END;
    INC(dx)
  UNTIL (diffCount > 1) OR (x-dx < 0) OR (x+dx-1=width);
  RETURN diffCount
END VerticalDiffs;

PROCEDURE HorizontalDiffs(y: INTEGER): INTEGER;
VAR x, dy, diffCount: INTEGER;
BEGIN
  diffCount := 0;
  dy := 1;
  REPEAT
    FOR x := 0 TO width-1 DO
      IF map[y-dy][x] # map[y+dy-1][x] THEN INC(diffCount) END;
    END;
    INC(dy)
  UNTIL (diffCount > 1) OR (y-dy < 0) OR (y+dy-1=height);
  RETURN diffCount
END HorizontalDiffs;

PROCEDURE ReadMap;
BEGIN
  height := 0;
  REPEAT
    In.Line(map[height]); INC(height);
  UNTIL map[height-1] = "";
  DEC(height);
  width := Strings.Length(map[0]);
END ReadMap;

PROCEDURE Sum;
VAR i, x,y, horizSum, vertSum: INTEGER;
    ch : CHAR;
BEGIN
  horizSum := 0; vertSum := 0;
  REPEAT
    ReadMap;
    FOR y := 1 TO height-1 DO
      IF HorizontalDiffs(y)=1 THEN horizSum := horizSum + y END;
    END;
    FOR x := 1 TO width-1 DO
      IF VerticalDiffs(x)=1 THEN vertSum := vertSum + x END;
    END;
    In.Char(ch); Streams.ReadAgain(Streams.input);
  UNTIL ch = EOL;
  Out.Long(LONG(vertSum) + LONG(100)*LONG(horizSum), 1); Out.Ln;
END Sum;

BEGIN
  Sum
END Day13b.
