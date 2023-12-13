MODULE Day08a;
IMPORT In, Out, Strings;
CONST NbNodes = 746;
TYPE DescNode = RECORD
                  name, leftName, rightName : ARRAY 4 OF CHAR;
                  left, right : INTEGER
                END;
VAR nodes : ARRAY NbNodes+1 OF DescNode;
    instructions: ARRAY 300 OF CHAR;

PROCEDURE ReadInput;
VAR i, j, sum: INTEGER;
    buf: ARRAY 40 OF CHAR;
BEGIN
  In.Line(instructions);
  In.Line(buf);

  FOR i := 1 TO NbNodes DO
    In.Name(nodes[i].name);
    In.Name(buf); ASSERT(buf = "=");
    In.Name(buf); Strings.Extract(buf, 1, 3, nodes[i].leftName);
    In.Line(buf); Strings.Extract(buf, 1, 3, nodes[i].rightName);
  END;

  FOR i := 1 TO NbNodes DO
    FOR j := 1 TO NbNodes DO
      IF nodes[i].leftName  = nodes[j].name THEN nodes[i].left  := j END;
      IF nodes[i].rightName = nodes[j].name THEN nodes[i].right := j END;
    END;
    ASSERT( nodes[i].left  # 0 );
    ASSERT( nodes[i].right # 0 );
  END;
END ReadInput;

PROCEDURE Search;
VAR i, nbInstructions, steps, location, end: INTEGER;
    direction : CHAR;
BEGIN
  FOR i := 1 TO NbNodes DO
    IF nodes[i].name = "AAA" THEN location := i END;
    IF nodes[i].name = "ZZZ" THEN end      := i END;
  END;

  nbInstructions := Strings.Length(instructions);
  steps := 0;
  REPEAT
    direction := instructions[steps MOD nbInstructions];
    INC(steps);
    IF direction = "L" THEN location := nodes[location].left END;
    IF direction = "R" THEN location := nodes[location].right END;
  UNTIL location = end;

  Out.Int(steps, 1); Out.Ln;
END Search;

BEGIN
  ReadInput;
  Search
END Day08a.
