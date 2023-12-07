MODULE DAY01A;
IMPORT In, Out;

PROCEDURE ParseLine(VAR first, last: INTEGER);
VAR line    : ARRAY 100 OF CHAR;
    found : BOOLEAN;
    i : INTEGER;
BEGIN
  In.Line(line);
  i := 0;
  found := FALSE;
  WHILE line[i] # 0X DO
    IF (line[i]>="0") & (line[i]<="9") THEN
      IF ~found THEN
        first := ORD(line[i])-ORD("0");
        found := TRUE
      END;
      last  := ORD(line[i])-ORD("0")
    END;
    INC(i)
  END;
END ParseLine;

PROCEDURE Sum;
VAR first, last, i: INTEGER;
    sum : LONGINT;
BEGIN
  sum := LONG(0);
  FOR i:=1 TO 1000 DO
    ParseLine(first,last);
    sum := sum + LONG(first * 10 + last);
  END;
  Out.Long(sum, 1); Out.Ln
END Sum;

BEGIN
  Sum
END DAY01A.
