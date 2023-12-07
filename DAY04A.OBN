MODULE Day04a;
IMPORT In, Out, Strings;
CONST NbCards = 198;

PROCEDURE ReadCards;
VAR card, i, j, num, value: INTEGER;
    sum : LONGINT;
    buf: ARRAY 8 OF CHAR;
    ch : CHAR;
    wins: ARRAY 10 OF INTEGER;
BEGIN
  sum := LONG(0);
  FOR card:=1 TO NbCards DO
    value := 0;
    In.Name(buf); In.Int(num); ASSERT(num = card);
    In.Char(ch); ASSERT(ch = ":");
    FOR i := 0 TO 9 DO
      In.Int(wins[i]);
    END;
    In.Char(ch); ASSERT(ch = " ");
    In.Char(ch); ASSERT(ch = "|");
    In.Char(ch); ASSERT(ch = " ");
    FOR i := 1 TO 25 DO
      In.Int(num);
      FOR j := 0 TO 9 DO
        IF num = wins[j] THEN
          IF value = 0 THEN value := 1 ELSE value := value + value END;
        END;
      END;
    END;
    sum := sum + LONG(value)
  END;
  Out.Long(sum, 1); Out.Ln
END ReadCards;

BEGIN
  ReadCards;
END Day04a.
