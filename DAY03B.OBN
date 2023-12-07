MODULE Day03b;
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
    map[0][x] := ".";
    map[Size+1][x] := ".";
    map[x][0] := ".";
    map[x][Size+1] := ".";
  END;
END ReadMap;

PROCEDURE IsDigit(c: CHAR): BOOLEAN;
BEGIN
  RETURN (c >= "0") & (c <= "9")
END IsDigit;

PROCEDURE FindPart(x,y: INTEGER; VAR value: INTEGER);
BEGIN
  value := 0;
  IF IsDigit(map[y][x]) THEN
    WHILE IsDigit(map[y][x]) DO DEC(x) END;
    INC(x);
    WHILE IsDigit(map[y][x]) DO
      value := value * 10 + ORD(map[y][x]) - ORD("0");
      INC(x)
    END;
  END;
END FindPart;

PROCEDURE SearchGears;
VAR x,y,nbOfParts,value: INTEGER;
    prod, sum : LONGINT;
BEGIN
  sum := LONG(0);
  FOR y := 1 TO Size DO
    FOR x := 1 TO Size DO
      IF map[y][x]="*" THEN
        prod := LONG(1); nbOfParts := 0;
        FindPart(x-1,y-1,value); IF value # 0 THEN INC(nbOfParts); prod := prod * LONG(value) END;
        FindPart(x-1,y  ,value); IF value # 0 THEN INC(nbOfParts); prod := prod * LONG(value) END;
        FindPart(x+1,y  ,value); IF value # 0 THEN INC(nbOfParts); prod := prod * LONG(value) END;
        FindPart(x-1,y+1,value); IF value # 0 THEN INC(nbOfParts); prod := prod * LONG(value) END;;
        IF ~IsDigit(map[y-1][x-1]) THEN FindPart(x  ,y-1,value); IF value # 0 THEN INC(nbOfParts); prod := prod * LONG(value) END; END;
        IF ~IsDigit(map[y-1][x  ]) THEN FindPart(x+1,y-1,value); IF value # 0 THEN INC(nbOfParts); prod := prod * LONG(value) END; END;
        IF ~IsDigit(map[y+1][x-1]) THEN FindPart(x  ,y+1,value); IF value # 0 THEN INC(nbOfParts); prod := prod * LONG(value) END; END;
        IF ~IsDigit(map[y+1][x  ]) THEN FindPart(x+1,y+1,value); IF value # 0 THEN INC(nbOfParts); prod := prod * LONG(value) END; END;
        IF nbOfParts = 2 THEN sum := sum + prod END;
      END;
    END;
  END;
  Out.Long(sum,1); Out.Ln;
END SearchGears;

BEGIN
  ReadMap;
  SearchGears
END Day03b.
