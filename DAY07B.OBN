MODULE Day07b;

(* do this puzzle with signed 32-bit integers instead of unsigned values...
   This requires the assumption that intervals are smaller than 2^31,
   and a positive check on differences...
 *)

IMPORT In, Out, Strings;
CONST Strengths = "J23456789TQKA";
      NbHands = 1000;
TYPE Hand = RECORD
              bid, kind : INTEGER;
              cards: ARRAY 5 OF CHAR;
            END;
VAR strengths: ARRAY 14 OF CHAR;
    hands: ARRAY NbHands+1 OF Hand;

PROCEDURE ReplaceHand(VAR hand: Hand);
VAR i,j, kind, pairs, jokers: INTEGER;
    counts: ARRAY 15 OF INTEGER;
BEGIN
  FOR i := 2 TO 14 DO counts[i] := 0 END;

  FOR i := 0 TO 4 DO
    FOR j := 0 TO 12 DO
      IF hand.cards[i] = strengths[j] THEN hand.cards[i] := CHR(j+2) END;
    END;
  END;

  FOR i := 0 TO 4 DO INC(counts[ORD(hand.cards[i])]) END;

  kind := 1; pairs := 0;
  FOR i := 2 TO 14 DO
    IF counts[i] = 2 THEN INC(pairs) END;
    IF counts[i] > kind THEN kind := counts[i] END;
  END;
  jokers := counts[2];
  IF jokers # 0 THEN
    IF jokers = kind THEN
      CASE jokers OF
      | 1 : kind := 2 ; pairs := 1
      | 2 : IF pairs = 2 THEN kind := 4; pairs := 0 ELSE kind := 3; pairs := 0 END;
      | 3 : IF pairs = 1 THEN kind := 5; pairs := 0 ELSE kind := 4; pairs := 0 END;
      | 4 : kind := 5
      | 5 : kind := 5
      END;
    ELSE
      CASE kind OF
      | 2 : kind := 3; pairs := pairs - 1
      | 3 : kind := kind + jokers; pairs := 0
      | 4 : kind := 5
      | 5 : kind := 5
      END;
    END;
  END;
  hand.kind := kind * 10 + pairs;
END ReplaceHand;

PROCEDURE IsWeaker(hand1, hand2: Hand): BOOLEAN;
VAR weaker: BOOLEAN;
    i : INTEGER;
BEGIN
  IF hand1.kind # hand2.kind THEN weaker := hand1.kind < hand2.kind
  ELSE
    i := 0;
    WHILE hand1.cards[i] = hand2.cards[i] DO INC(i) END;
    weaker := hand1.cards[i] < hand2.cards[i]
  END;
  RETURN weaker
END IsWeaker;

PROCEDURE SortHands;
VAR tmp: Hand;
    i, j, min: INTEGER;
BEGIN
  FOR i := 1 TO NbHands DO
    min := i;
    FOR j := i+1 TO NbHands DO
      IF IsWeaker(hands[j], hands[min]) THEN min := j END;
    END;
    tmp := hands[i]; hands[i] := hands[min]; hands[min] := tmp;
  END;
END SortHands;

PROCEDURE ReadCards;
VAR i  : INTEGER;
    sum: LONGINT;
    buf: ARRAY 40 OF CHAR;
BEGIN
  strengths := Strengths;
  FOR i:=1 TO NbHands DO
    In.Char(hands[i].cards[0]);
    In.Char(hands[i].cards[1]);
    In.Char(hands[i].cards[2]);
    In.Char(hands[i].cards[3]);
    In.Char(hands[i].cards[4]);
    In.Int(hands[i].bid); In.Line(buf);
    ReplaceHand(hands[i]);
  END;
  SortHands;
  sum := LONG(0);
  FOR i := 1 TO NbHands DO
    sum := sum + LONG(i) * LONG(hands[i].bid);
  END;
  Out.Long(sum, 1); Out.Ln
END ReadCards;

BEGIN
  ReadCards;
END Day07b.
