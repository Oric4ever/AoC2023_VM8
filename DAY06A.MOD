MODULE Day06a;

IMPORT In, Out, Strings;
CONST NbRaces = 4;

PROCEDURE ReadRace;
VAR i, try, nbWins: INTEGER;
    score : LONGINT;
    buf: ARRAY 40 OF CHAR;
    times  : ARRAY NbRaces+1 OF INTEGER;
    records: ARRAY NbRaces+1 OF LONGINT;
BEGIN
  In.Name(buf); ASSERT( buf =  "Time:");
  FOR i := 1 TO NbRaces DO In.Int(times[i]) END;
  In.Line(buf); (* finishes the first line *)
  In.Name(buf); ASSERT( buf =  "Distance:");
  FOR i := 1 TO NbRaces DO In.Long(records[i]) END;

  score := LONG(1);
  FOR i := 1 TO NbRaces DO
    nbWins := 0;
    FOR try := 1 TO times[i] DO
      IF LONG(times[i] - try) * LONG(try) > records[i] THEN INC(nbWins) END;
    END;
    score := score * LONG(nbWins);
  END;
  Out.Long(score, 1); Out.Ln
END ReadRace;

BEGIN
  ReadRace;
END Day06a.
