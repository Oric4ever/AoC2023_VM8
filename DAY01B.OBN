MODULE Day01b;
IMPORT In, Out, Strings;
TYPE DigitName = ARRAY  8 OF CHAR;
VAR names      : ARRAY 10 OF DigitName; (* digits' names *)
    nameLengths: ARRAY 10 OF INTEGER;   (* digit names' lengths *)

PROCEDURE ParseLine(VAR firstDigit, lastDigit: INTEGER);
CONST MaxLineSize = 100;
VAR line        : ARRAY MaxLineSize OF CHAR;
    lineLength  : INTEGER;
    firstMatch  : BOOLEAN;
    index, digit: INTEGER;
    extract     : DigitName;
BEGIN
  In.Line(line); lineLength := Strings.Length(line);
  firstMatch := TRUE;
  FOR index := 0 TO lineLength-1 DO
    FOR digit := 1 TO 9 DO
      Strings.Extract(line, index, nameLengths[digit], extract);
      IF (line[index] = CHR(digit + ORD("0")))
      OR (extract = names[digit]) THEN
        lastDigit  := digit;
        IF firstMatch THEN firstDigit := digit; firstMatch := FALSE END;
      END;
    END;
  END;
END ParseLine;

PROCEDURE Sum;
CONST NbOfLines = 1000;
VAR firstDigit, lastDigit, line: INTEGER;
    sum : LONGINT;
BEGIN
  sum := LONG(0);
  FOR line := 1 TO NbOfLines DO
    ParseLine(firstDigit,lastDigit);
    sum := sum + LONG(firstDigit * 10 + lastDigit);
  END;
  Out.Long(sum, 1); Out.Ln
END Sum;

PROCEDURE Init;
  VAR digit : INTEGER;
BEGIN
  names[1] := "one";
  names[2] := "two";
  names[3] := "three";
  names[4] := "four";
  names[5] := "five";
  names[6] := "six";
  names[7] := "seven";
  names[8] := "eight";
  names[9] := "nine";
  FOR digit := 1 TO 9 DO
    nameLengths[digit] := Strings.Length(names[digit])
  END;
END Init;

BEGIN
  Init ; Sum
END Day01b.
