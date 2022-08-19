--  gprbuild jusanchezme.adb
--  gnatprove -P\\wsl.localhost\Ubuntu-20.04\home\juan\codeabbey\004\
--  jusanchezme.gpr -j0 --output=oneline --ide-progress-bar -u jusanchezme.adb
--  --warnings=off --level=4
--  Phase 1 of 2: generation of Global contracts ...
--  Phase 2 of 2: flow analysis and proof ...
--  Summary logged in \\wsl.localhost\Ubuntu-20.04\home\juan\codeabbey\004\
--  gnatprove\gnatprove.out
--  [2022-07-21 12:06:09] process terminated successfully,
--  elapsed time: 20.73s

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Maps; use Ada.Strings.Maps;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

procedure jusanchezme with
   SPARK_Mode => ON
is

   T : Integer;
   subtype Integer_Range is Integer range -(2 ** 31 - 1) .. +(2 ** 31 - 1);

   subtype T_Range is Integer range 0 .. +(2 ** 31 - 1);

   procedure ReadIn (T : Integer);

   function MinimumOfTwo
     (LeftNum : Integer_Range; RightNum : Integer_Range) return Integer;

   function DecreaseInt (T : in Integer) return Integer with
      Pre  => T > (Positive'First),
      Post => DecreaseInt'Result = T - 1;

   function DecreaseInt (T : in Integer) return Integer is
   begin
      return T - 1;
   end DecreaseInt;

   procedure PrintResult (Data : Integer);

   procedure PrintResult (Data : Integer) is
      Result : constant String :=
        Ada.Strings.Fixed.Trim (Integer'Image (Data), Ada.Strings.Left);
   begin
      Put (Item => Result);
   end PrintResult;

   procedure ReadIn (T : Integer) is
      NewT : Integer;
      LeftNum, RightNum : Integer;
      MyLeftNum, MyRightNum : Integer_Range;
      isLeftinRange, isRightinRange : Boolean;
      WhiteSpace : String := " ";

   begin
      Get (LeftNum);
      Get (RightNum);
      isLeftinRange  := LeftNum in Integer_Range;
      isRightinRange := RightNum in Integer_Range;
      if isLeftinRange and isRightinRange then
         MyLeftNum := LeftNum;
         MyRightNum := RightNum;
         PrintResult (MinimumOfTwo (MyLeftNum, MyRightNum));
      end if;

      if T in Integer_Range and T > 1 then
         Put (WhiteSpace);
         NewT := DecreaseInt (T);
         ReadIn (NewT);
      end if;
   end ReadIn;

   function MinimumOfTwo
     (LeftNum : Integer_Range; RightNum : Integer_Range) return Integer
   is
   begin
      if LeftNum <= RightNum then
         return LeftNum;
      else
         return RightNum;
      end if;
   end MinimumOfTwo;

   procedure main;

   procedure main is
   begin
      Get (T);
      if T in T_Range then
         ReadIn (T);
      end if;
   end main;
begin
   main;
end jusanchezme;

--  cat DATA.lst | ./jusanchezme
--  -7282578 -1006858 -9193294 1570897 3663440 -3258479 8385776 -4206188
--  -494094 -6767453 -9509706 -147130 -2740422 6400849 -3944940 1407663 6887911
--  2210324 -4841601 4867103 -2691290 -4476910 5705487 -857700 3922837 -1570320
--  -9896583 -4845103 5548530 6370633