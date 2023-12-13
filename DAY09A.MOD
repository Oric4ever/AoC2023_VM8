MODULE Day09a;
IMPORT In, Out, Streams;
CONST Lines = 200;
      EOL = 0AX;
VAR values : ARRAY 100 OF LONGINT;

PROCEDURE ReadInput;
VAR i, line, nbValues, power: INTEGER;
    extra, sum : LONGINT;
    allZeroes : BOOLEAN;
    ch : CHAR;
    buf: ARRAY 40 OF CHAR;
BEGIN
  sum := LONG(0);
  FOR line := 1 TO Lines DO
    nbValues := 0;
    REPEAT
      In.Long(values[nbValues]); INC(nbValues);
      In.Char(ch); Streams.ReadAgain(Streams.input); (* test if the next line is empty *)
    UNTIL ch = EOL;


    power := 0;
    REPEAT
      INC(power);
      allZeroes := TRUE;
      FOR i := 0 TO nbValues-power-1 DO
        values[i] := values[i+1] - values[i];
        IF values[i] # LONG(0) THEN allZeroes := FALSE END
      END;
    UNTIL allZeroes;

    extra := LONG(0);
    FOR i := 0 TO nbValues-1 DO extra := extra + values[i] END;
    sum := sum + extra;
  END;
  Out.Long(sum, 1); Out.Ln;
END ReadInput;

BEGIN
  ReadInput;
END Day09a.
