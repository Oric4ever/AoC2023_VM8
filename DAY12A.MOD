MODULE Day12a;
IMPORT In, Out, Strings;
CONST NbLines = 1000;
      EOL = 0AX;

PROCEDURE Match(buf: ARRAY OF CHAR; counts: ARRAY OF INTEGER; nbCounts: INTEGER): BOOLEAN;
  VAR i, length, countIndx: INTEGER;
      match: BOOLEAN;
BEGIN
  match := TRUE;
  countIndx := 0;
  i := 0; length := 0;
  WHILE (buf[i] # 0X) & match DO
    IF buf[i] = "." THEN
      IF length # 0 THEN
        match := counts[countIndx] = length;
        INC(countIndx);
        length := 0;
      END;
    ELSE (* buf[i] = "#" *)
      ASSERT( buf[i] = "#" );
      INC(length);
    END;
    INC(i)
  END;
  IF match & (length # 0) THEN match := counts[countIndx] = length; INC(countIndx) END;
  match := match & (countIndx = nbCounts);
  RETURN match
END Match;

PROCEDURE Arrangements(VAR buf: ARRAY OF CHAR; pos: INTEGER; counts: ARRAY OF INTEGER; nbCounts: INTEGER):  VAR arrangements, n1, n2 : LONGINT;
      ch : CHAR;
BEGIN
  arrangements := LONG(0);
  ch := buf[pos];
  CASE ch OF
  | 0X : IF Match(buf, counts, nbCounts) THEN arrangements := LONG(1) END;
  | ".": arrangements := Arrangements(buf, pos+1, counts, nbCounts)
  | "#": arrangements := Arrangements(buf, pos+1, counts, nbCounts)
  | "?": buf[pos] := "."; n1 := Arrangements(buf, pos+1, counts, nbCounts);
         buf[pos] := "#"; n2 := Arrangements(buf, pos+1, counts, nbCounts);
         buf[pos] := "?"; arrangements := n1 + n2
  END;
  RETURN arrangements
END Arrangements;

PROCEDURE ReadLine(VAR arrangements: LONGINT);
VAR buf: ARRAY 100 OF CHAR;
    values: ARRAY 10 OF INTEGER;
    nbValues: INTEGER;
    ch: CHAR;
BEGIN
  In.Name(buf);

  nbValues := 0;
  REPEAT
    In.Int(values[nbValues]);
    INC(nbValues);
    In.Char(ch);
  UNTIL ch = EOL;
  arrangements := Arrangements(buf, 0, values, nbValues);
END ReadLine;

PROCEDURE Sum;
VAR line: INTEGER;
    count, sum : LONGINT;
BEGIN
  sum := LONG(0);
  FOR line := 1 TO 1000 DO
    Out.Int(line, 1); Out.Ln; (* show some progress *)
    ReadLine(count);
    sum := sum + count
  END;
  Out.Long(sum, 1); Out.Ln;
END Sum;

BEGIN
  Sum
END Day12a.
