MODULE Day08b;
IMPORT In, Out, Strings, BigNum;
CONST NbNodes = 746;
TYPE DescNode = RECORD
                  name, leftName, rightName : ARRAY 4 OF CHAR;
                  left, right : INTEGER
                END;
VAR nodes       : ARRAY NbNodes+1 OF DescNode;
    instructions: ARRAY 300 OF CHAR;
    ghosts      : ARRAY  10 OF INTEGER;
    nbOfGhosts  : INTEGER;

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
    ASSERT( nodes[i].left # 0 );
    ASSERT( nodes[i].right # 0 );
  END;
END ReadInput;

PROCEDURE Search;
VAR i, nbInstructions, steps, location: INTEGER;
    direction : CHAR;
    end : BOOLEAN;
BEGIN
  nbOfGhosts := 0;
  FOR i := 1 TO NbNodes DO
    IF nodes[i].name[2] = "A" THEN INC(nbOfGhosts); ghosts[nbOfGhosts] := i END;
  END;

  nbInstructions := Strings.Length(instructions);
  FOR i := 1 TO nbOfGhosts DO
    location := ghosts[i];
    steps    := 0;
    end      := FALSE;
    REPEAT
      direction := instructions[steps MOD nbInstructions];
      INC(steps);
      end := TRUE;
      IF direction = "L" THEN location := nodes[location].left END;
      IF direction = "R" THEN location := nodes[location].right END;
    UNTIL nodes[location].name[2] = "Z";
    ghosts[i] := steps;
  END;
END Search;

PROCEDURE Gcd(a,b: BigNum.Int64; VAR gcd: BigNum.Int64);
  VAR x, y, tmp, quotient, remainder: BigNum.Int64;
      buf: ARRAY 20 OF CHAR;
BEGIN
  x := a; y := b;
  WHILE ~BigNum.IsZero(y) DO
    BigNum.Div(x, y, tmp, quotient, remainder);
    x := y;
    y := remainder;
  END;
  gcd := x;
END Gcd;

PROCEDURE Lcm;
  VAR x, lcm, gcd, tmp, quotient, remainder, product: BigNum.Int64;
      i   : INTEGER;
      buf : ARRAY 20 OF CHAR;
BEGIN
  BigNum.FromInt(ghosts[1], lcm);
  FOR i := 2 TO nbOfGhosts DO
    BigNum.FromInt(ghosts[i] DIV 271, x); (* there's currently a bug in BigNum.Div !! *)
    BigNum.Mul(lcm, x, tmp, product);
    lcm := product;
  END;
  BigNum.ToString(lcm, buf); Out.String(buf); Out.Ln;
END Lcm;

BEGIN
  ReadInput;
  Search;
  Lcm;
END Day08b.
