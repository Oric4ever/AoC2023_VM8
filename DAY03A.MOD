MODULE Day03a;
IMPORT In, Out, Strings;
CONST Size = 140;
      DOT  = ".";
VAR map: ARRAY Size+2,Size+2 OF CHAR;

PROCEDURE ReadMap;
VAR x,line: INTEGER;
    endOfLine: ARRAY 4 OF CHAR;
BEGIN
  FOR line:=1 TO Size DO
    FOR x:=1 TO Size DO
      In.Char(map[line][x])
    END;
    In.Line(endOfLine);
  END;
  FOR x:=0 TO Size+1 DO
    map[0     ][x     ] := DOT;
    map[Size+1][x     ] := DOT;
    map[x     ][0     ] := DOT;
    map[x     ][Size+1] := DOT;
  END;
END ReadMap;

PROCEDURE IsDigit(c: CHAR): BOOLEAN;
BEGIN
  RETURN (c >= "0") & (c <= "9")
END IsDigit;

PROCEDURE PartLength(x,y: INTEGER): INTEGER;
VAR dx: INTEGER;
BEGIN
  dx := 0;
  WHILE IsDigit(map[y][x+dx]) DO INC(dx) END;
  RETURN dx
END PartLength;

PROCEDURE IsSymbol(c: CHAR): BOOLEAN;
BEGIN
  RETURN ~IsDigit(c) & (c # DOT)
END IsSymbol;

PROCEDURE IsPartNum(x1,x2,y1: INTEGER): BOOLEAN;
VAR x,y: INTEGER;
    isPart: BOOLEAN;
BEGIN
  isPart := FALSE;
  FOR y := y1-1 TO y1+1 DO
    FOR x := x1-1 TO x2+1 DO
      isPart := isPart OR IsSymbol(map[y][x]);
    END;
  END;
  RETURN isPart
END IsPartNum;

PROCEDURE Value(x1,x2,y: INTEGER): INTEGER;
  VAR x, value: INTEGER;
BEGIN
  value := 0;
  FOR x := x1 TO x2 DO
    value := value * 10 + ORD(map[y][x]) - ORD("0")
  END;
  RETURN value
END Value;

PROCEDURE SearchParts;
VAR x1,x2,y1,num: INTEGER;
    sum : LONGINT;
BEGIN
  sum := LONG(0);
  FOR y1 := 1 TO Size DO
    FOR x1 := 1 TO Size DO
      IF IsDigit(map[y1][x1]) & ~IsDigit(map[y1][x1-1]) THEN
        x2 := x1 + PartLength(x1,y1) - 1;
        IF IsPartNum(x1,x2,y1) THEN
          sum := sum + LONG(Value(x1,x2,y1))
        END;
      END;
    END;
  END;
  Out.Long(sum,1); Out.Ln;
END SearchParts;

BEGIN
  ReadMap;
  SearchParts
END Day03a.
