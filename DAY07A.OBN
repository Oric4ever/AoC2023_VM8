MODULE Day07a;
IMPORT In, Out, Strings;
CONST Strengths = "23456789TJQKA";
      NbHands = 1000;
TYPE Hand = RECORD
              bid, kind : INTEGER;
              cards: ARRAY 5 OF CHAR;
            END;
VAR strengths: ARRAY 14 OF CHAR;
    hands: ARRAY NbHands+1 OF Hand;

PROCEDURE ReplaceHand(VAR hand: Hand);
VAR i,j, kind, pairs: INTEGER;
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
END Day07a.


