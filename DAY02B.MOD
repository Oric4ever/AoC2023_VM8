MODULE Day02b;
IMPORT In, Out, Strings;

PROCEDURE ReadSet(VAR red, green, blue: INTEGER; VAR lastSet: BOOLEAN);
VAR word  : ARRAY 8 OF CHAR;
    commaFound, separator : BOOLEAN;
    nb, wordLength : INTEGER;
BEGIN
  red := 0; green := 0; blue := 0;
  REPEAT
    In.Int(nb);
    In.Name(word); wordLength := Strings.Length(word);
    commaFound := word[wordLength-1] = ",";
    lastSet    := word[wordLength-1] # ";";
    IF commaFound OR ~lastSet THEN word[wordLength-1] := 0X END;
    IF word = "red"   THEN red   := nb END;
    IF word = "green" THEN green := nb END;
    IF word = "blue"  THEN blue  := nb END;
  UNTIL ~commaFound;
END ReadSet;

PROCEDURE CheckLine(VAR power: INTEGER);
VAR word: ARRAY 8 OF CHAR;
    n   : INTEGER;
    red, green, blue: INTEGER;
    minRed, minGreen, minBlue: INTEGER;
    lastSet: BOOLEAN;
BEGIN
  minRed := 0; minBlue := 0; minGreen := 0;
  In.Name(word); ASSERT( word = "Game" );
  In.Name(word);
  REPEAT
    ReadSet(red, green, blue, lastSet);
    IF red   > minRed   THEN minRed   := red   END;
    IF green > minGreen THEN minGreen := green END;
    IF blue  > minBlue  THEN minBlue  := blue  END;
  UNTIL lastSet;
  power := minRed * minGreen * minBlue;
END CheckLine;

PROCEDURE Sum;
  VAR line, power: INTEGER;
      sum: LONGINT;
BEGIN
  sum := LONG(0);
  FOR line := 1 TO 100 DO
    CheckLine(power);
    sum := sum + LONG(power);
  END;
  Out.Ln; Out.Long(sum, 1); Out.Ln
END Sum;

BEGIN
  Sum
END Day02b.
