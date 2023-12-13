MODULE Day11a;
IMPORT In, Out, Strings;
CONST Size = 140;
      EOL = 0AX;
TYPE Coord = RECORD x,y: INTEGER END;
VAR map1 : ARRAY Size,Size+2 OF CHAR;
    stars: ARRAY 2000 OF Coord;
    emptyRows, emptyCols: ARRAY Size OF BOOLEAN;
    nbStars : INTEGER;

PROCEDURE ReadMap;
VAR y, x: INTEGER;
BEGIN
  FOR y := 0 TO Size-1 DO In.Line(map1[y]) END;
END ReadMap;

PROCEDURE Expand;
VAR y, x, expandedX, expandedY: INTEGER;
BEGIN
  FOR y := 0 TO Size-1 DO
    emptyRows[y] := TRUE;
    FOR x := 0 TO Size-1 DO
      IF map1[y][x] = "#" THEN emptyRows[y] := FALSE END;
    END;
  END;

  FOR x := 0 TO Size-1 DO
    emptyCols[x] := TRUE;
    FOR y := 0 TO Size-1 DO
      IF map1[y][x] = "#" THEN emptyCols[x] := FALSE END;
    END;
  END;

  nbStars := 0; expandedY := 0;
  FOR y := 0 TO Size-1 DO
    expandedX := 0;
    FOR x := 0 TO Size-1 DO
      IF map1[y][x] = "#" THEN
        stars[nbStars].x := expandedX;
        stars[nbStars].y := expandedY;
        INC(nbStars)
      ELSIF emptyCols[x] THEN INC(expandedX)
      END;
      INC(expandedX)
    END;
    INC(expandedY); IF emptyRows[y] THEN INC(expandedY) END;
  END;
END Expand;

PROCEDURE Distance(indx1, indx2: INTEGER): INTEGER;
BEGIN
  RETURN ABS(stars[indx1].x - stars[indx2].x) + ABS(stars[indx1].y - stars[indx2].y)
END Distance;

PROCEDURE Sum;
VAR i,j: INTEGER;
    sum: LONGINT;
BEGIN
  sum := LONG(0);
  FOR i := 0 TO nbStars-2 DO
    FOR j := i TO nbStars-1 DO
      sum := sum + LONG(Distance(i,j))
    END;
  END;
  Out.Long(sum, 1); Out.Ln;
END Sum;

BEGIN
  ReadMap;
  Expand;
  Sum
END Day11a.
