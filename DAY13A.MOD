MODULE Day13a;
IMPORT In, Out, Strings, Streams;
CONST Size = 100;
      EOL = 0AX;
VAR map : ARRAY Size,Size+2 OF CHAR;
    width, height: INTEGER;

PROCEDURE VerticalMirror(x: INTEGER): BOOLEAN;
VAR y, dx: INTEGER;
    mirrors: BOOLEAN;
BEGIN
  mirrors := TRUE;
  dx := 1;
  REPEAT
    FOR y := 0 TO height-1 DO
      IF map[y][x-dx] # map[y][x+dx-1] THEN mirrors := FALSE END;
    END;
    INC(dx)
  UNTIL ~mirrors OR (x-dx < 0) OR (x+dx-1=width);
  RETURN mirrors
END VerticalMirror;

PROCEDURE HorizontalMirror(y: INTEGER): BOOLEAN;
VAR dy: INTEGER;
    mirrors : BOOLEAN;
BEGIN
  mirrors := TRUE;
  dy := 1;
  REPEAT
    IF map[y-dy] # map[y+dy-1] THEN mirrors := FALSE END;
    INC(dy)
  UNTIL ~mirrors OR (y-dy < 0) OR (y+dy-1=height);
  RETURN mirrors
END HorizontalMirror;

PROCEDURE ReadMap;
VAR y, x: INTEGER;
    ch : CHAR;
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
      IF HorizontalMirror(y) THEN horizSum := horizSum + y END;
    END;
    FOR x := 1 TO width-1 DO
      IF VerticalMirror(x) THEN vertSum := vertSum + x END;
    END;
    In.Char(ch); Streams.ReadAgain(Streams.input);
  UNTIL ch = EOL;
  Out.Int(vertSum + 100*horizSum, 1); Out.Ln;
END Sum;

BEGIN
  Sum
END Day13a.
