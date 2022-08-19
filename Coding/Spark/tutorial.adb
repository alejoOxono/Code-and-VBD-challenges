Designating SPARK Code

package P
  with SPARK_Mode => On
is
   -- package spec is IN SPARK, so can be used by SPARK clients
end P;

package body P
  with SPARK_Mode => Off
is
   -- body is NOT IN SPARK, so is ignored by GNATprove
end P;

***********

function Incr (X : Integer) return Integer;

procedure Push (S : in out Stack; E : Element);

+++++++++++