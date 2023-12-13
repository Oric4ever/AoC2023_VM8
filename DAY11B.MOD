MODULE Day11b;
IMPORT In, Out, BigNum;
CONST Size = 140;
      EOL = 0AX;
TYPE Coord = RECORD x,y: LONGINT END;
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
VAR y, x: INTEGER;
    expandedX, expandedY : LONGINT;
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

  nbStars := 0; expandedY := LONG(0);
  FOR y := 0 TO Size-1 DO
    expandedX := LONG(0);
    FOR x := 0 TO Size-1 DO
      IF map1[y][x] = "#" THEN
        stars[nbStars].x := expandedX;
        stars[nbStars].y := expandedY;
        INC(nbStars)
      ELSIF emptyCols[x] THEN expandedX := expandedX + LONG(1000)*LONG(1000)-LONG(1)
      END;
      expandedX := expandedX + LONG(1)
    END;
    IF emptyRows[y]
    THEN expandedY := expandedY + LONG(1000)*LONG(1000)
    ELSE expandedY := expandedY + LONG(1)
    END;
  END;
END Expand;

PROCEDURE Distance(indx1, indx2: INTEGER): LONGINT;
BEGIN
  RETURN ABS(stars[indx1].x - stars[indx2].x) + ABS(stars[indx1].y - stars[indx2].y)
END Distance;

PROCEDURE Sum;
VAR i,j: INTEGER;
    sum, dist: BigNum.Int64;
    buf: ARRAY 40 OF CHAR;
BEGIN
  BigNum.FromInt(0, sum);
  FOR i := 0 TO nbStars-2 DO
    FOR j := i TO nbStars-1 DO
      BigNum.FromLong( Distance(i,j), dist );
      BigNum.Add(sum, dist, sum);
    END;
  END;
  BigNum.ToString(sum, buf);
  Out.String(buf); Out.Ln
END Sum;

BEGIN
  ReadMap;
  Expand;
  Sum
END Day11b.
