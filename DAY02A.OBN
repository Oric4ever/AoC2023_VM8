MODULE Day02a;
IMPORT In, Out, Strings;

PROCEDURE ReadSet(VAR red, green, blue: INTEGER; VAR lastSet: BOOLEAN);
VAR word  : ARRAY 8 OF CHAR;
    continue, separator : BOOLEAN;
    nb, wordLength : INTEGER;
BEGIN
  red := 0; green := 0; blue := 0;
  REPEAT
    In.Int(nb);
    In.Name(word); wordLength := Strings.Length(word);
    continue  := word[wordLength-1] = ",";
    separator := word[wordLength-1] = ";";
    IF continue OR separator THEN word[wordLength-1] := 0X END;
    IF word = "red"   THEN red   := nb END;
    IF word = "green" THEN green := nb END;
    IF word = "blue"  THEN blue  := nb END;
  UNTIL ~continue;
  lastSet := ~separator
END ReadSet;

PROCEDURE CheckLine(VAR possible: BOOLEAN);
VAR word: ARRAY 8 OF CHAR;
    n   : INTEGER;
    red, green, blue: INTEGER;
    lastSet: BOOLEAN;
BEGIN
  possible := TRUE;
  In.Name(word); ASSERT( word = "Game" );
  In.Name(word);
  REPEAT
    ReadSet(red, green, blue, lastSet);
    IF (red > 12) OR (green > 13) OR (blue > 14) THEN possible := FALSE END;
  UNTIL lastSet;
END CheckLine;

PROCEDURE Sum;
  VAR line, sum: INTEGER;
      possible: BOOLEAN;
BEGIN
  sum := 0;
  FOR line := 1 TO 100 DO
    CheckLine(possible);
    IF possible THEN sum := sum + line END;
  END;
  Out.Ln; Out.Int(sum, 1); Out.Ln
END Sum;

BEGIN
  Sum
END Day02a.
