MODULE Day05b;

(* doing this puzzle with signed 32-bit integers because I don't have unsigned types...
   This requires the assumption that intervals are smaller than 2^31,
   and a positive check on differences...
 *)

IMPORT In, Out, Streams;
CONST NbIntervals = 10;
      LineFeed = 0AX;

TYPE IntList  = POINTER TO Interval;
     Interval = RECORD
                 start, length: LONGINT;
                 next: IntList
               END;

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

PROCEDURE Prepend(interval: IntList; VAR list: IntList);
BEGIN
  interval.next := list;
  list := interval
END Prepend;

PROCEDURE ReadMappings;
VAR i, mapping: INTEGER;
    dist, destination, start, length, min: LONGINT;
    buf: ARRAY 40 OF CHAR;
    ch : CHAR;
    interval, interval2, list, mapped, mappedList : IntList;
BEGIN
  In.Name(buf); ASSERT( buf =  "seeds:");
  list := NIL;
  FOR i := 1 TO NbIntervals DO
    NEW(interval);
    ReadLong(interval.start);
    ReadLong(interval.length);
    Prepend(interval, list);
  END;
  In.Line(buf); (* finishes the first line *)

  FOR mapping := 1 TO 7 DO
    mappedList := NIL;
    In.Line(buf); ASSERT( buf = "" );
    In.Line(buf); Out.String(buf); Out.Ln;
    REPEAT
      ReadLong(destination);
      ReadLong(start);
      ReadLong(length); ASSERT(length >= LONG(1));
      interval := list;
      WHILE interval # NIL DO
        IF interval.length # LONG(0) THEN (* skip empty intervals *)
          dist := interval.start - start;
          IF (dist >= LONG(0)) & (dist < length) THEN (* the start of the interval is mapped *)
            NEW(mapped); Prepend(mapped, mappedList);
            mapped.start  := destination + dist;
            IF dist + interval.length <= length THEN (* the whole interval is mapped *)
              mapped  .length := interval.length;
              interval.length := LONG(0); (* so disable the original interval *)
            ELSE (* map only the first part *)
              mapped  .length := length - dist;
              interval.start  := start + length; (* and reduce the original interval *)
              interval.length := interval.length - mapped.length;
            END;
          ELSIF (dist < LONG(0)) & (-dist < interval.length) THEN
            (* split the current interval in two, the last part will be mapped during next iteration *)
            NEW(interval2);
            interval2.start  := start;
            interval2.length := interval.length + dist; (* dist is < 0 *)
            interval2.next   := interval.next;
            (* the first part of the interval remains unmapped *)
            interval.length  := -dist;
            interval.next    := interval2;
          END;
        END;
        interval := interval.next;
      END;
      In.Line(buf); ASSERT( buf = "" );
      In.Char(ch); Streams.ReadAgain(Streams.input); (* test if the next line is empty *)
    UNTIL ch = LineFeed;
    (* add the mapped intervals to the list *)
    WHILE mappedList # NIL DO
      mapped := mappedList; mappedList := mapped.next;
      Prepend(mapped, list)
    END;
  END;

  min := LONG(32767,-1);
  mapped := list;
  WHILE mapped # NIL DO
    IF (mapped.length # LONG(0))
     & (mapped.start >= LONG(0))
     & (mapped.start  < min) THEN min := mapped.start END;
    mapped := mapped.next
  END;
  Out.Long(min, 1); Out.Ln
END ReadMappings;

BEGIN
  ReadMappings;
END Day05b.


