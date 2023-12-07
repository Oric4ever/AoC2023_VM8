MODULE Day05a;

(* solving this puzzle with signed 32-bit integers instead of unsigned values...
   This requires the assumption that intervals are smaller than 2^31,
   and a positive check on differences...
 *)

IMPORT In, Out, Streams;
CONST NbSeeds = 20;
      LineFeed = 0AX;

(* In.Long and Scan.Long in the library don't cope with overflows, so write a new ReadLong here : *)
PROCEDURE ReadLong(VAR x: LONGINT);
  VAR ch: CHAR;
BEGIN
  x := LONG(0);
  In.Char(ch);
  WHILE ch = " " DO In.Char(ch) END;
  WHILE (ch >= "0") & (ch <= "9") DO
    x := x * LONG(10) + LONG(ORD(ch) - ORD("0"));
    In.Char(ch)
  END;
  Streams.ReadAgain(Streams.input)
END ReadLong;

PROCEDURE ReadMappings;
VAR i, mapping: INTEGER;
    offset, destination, start, length, min: LONGINT;
    buf: ARRAY 40 OF CHAR;
    ch : CHAR;
    seeds, mapped : ARRAY NbSeeds+1 OF LONGINT;
BEGIN
  In.Name(buf); ASSERT( buf =  "seeds:");
  FOR i := 1 TO NbSeeds DO In.Long(seeds[i]) END;
  In.Line(buf); (* finishes the first line *)

  FOR mapping := 1 TO 7 DO
    FOR i := 1 TO NbSeeds DO mapped[i] := seeds[i] END;
    In.Line(buf); ASSERT( buf = "" );
    In.Line(buf); Out.String(buf); Out.Ln;
    REPEAT
      ReadLong(destination);
      ReadLong(start);
      ReadLong(length); ASSERT(length >= LONG(1));
      FOR i := 1 TO NbSeeds DO
        offset := seeds[i] - start;
        IF (offset >= LONG(0)) & (offset < length) THEN mapped[i] := destination + offset END;
      END;
      In.Line(buf); ASSERT( buf = "" );
      In.Char(ch); Streams.ReadAgain(Streams.input); (* test if the next line is empty *)
    UNTIL ch = LineFeed;
    FOR i := 1 TO NbSeeds DO seeds[i] := mapped[i] END;
  END;

  min := LONG(32767)*LONG(32767);
  FOR i := 1 TO NbSeeds DO
    IF (mapped[i] >= LONG(0)) & (mapped[i] < min) THEN min := mapped[i] END;
  END;
  Out.Long(min, 1); Out.Ln
END ReadMappings;

BEGIN
  ReadMappings;
END Day05a.
