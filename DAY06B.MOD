MODULE Day06b;
(*
   - simpler than first part: mathematically solves the 2nd degree equation...

   Speed is the time spent on the accelerate button,
   travelled distance is equal to the remaining time multiplied by the speed.

   Looking for speed values such that  (Time - speed) * speed > Record,
   Time/2 is the best value : it gives Time*Time/4.
   The other values that are better than the Record are equally balanced around this Time/2 value.
   Let's see what is the non-integer speed value that would equate the Record :
   (Time - speed) * speed = Record  <=>  speed*speed - Time*speed + Record = 0

   Discriminant of the 2nd degree equation : Delta = Time*Time - 4 Record
   Roots of the equation : (Time - sqrt(Delta))/2    and   (Time + sqrt(Delta))/2
   sqrt(Delta) is not integer, so truncate to integer to find the last value that gives a better distance than the Record.

   Unfortunately, my simple precision implementation does not have enough digits,
   so I got 27102787 instead of the correct result (27102791)...
 *)

IMPORT In, Out;
CONST Time = 40828492.0;
      Record = 2.33101111101487E14;
VAR delta: REAL;
    semiIntervalSize, nbBetter: LONGINT;

(* Oops, I haven't written the Math library yet, so let's implement sqrt with Newton's method *)
PROCEDURE sqrt(x: REAL):REAL;
VAR y: REAL;
BEGIN
  y := x/2.0;
  REPEAT
    y := (y + x/y) / 2.0
  UNTIL ABS(y*y - x) / x < 1.0E-6;
  RETURN y
END sqrt;

BEGIN
  delta := Time*Time - 4.0*Record;
  semiIntervalSize := FLOOR( sqrt(delta)/2.0 );
  nbBetter := semiIntervalSize + semiIntervalSize + LONG(1);
  Out.Long( nbBetter, 1); Out.Ln
END Day06b.
