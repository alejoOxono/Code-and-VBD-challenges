--  gnatprove -P/home/alejo/GNATstudio/first.gpr -j0
--  --output=oneline --ide-progress-bar -u alejo0xono.adb --level=4
--  Phase 1 of 2: generation of Global contracts ...
--  Phase 2 of 2: flow analysis and proof ...
--  Summary logged in /home/alejo/GNATstudio/obj/gnatprove/gnatprove.out
--  [2022-09-05 12:06:50] process terminated successfully, elapsed time: 02.49s
--  gprbuild alejo0xono.adb

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure alejo0xono with
   SPARK_Mode => ON
is

   subtype Sub_Int is Integer range 0 .. +(2 ** 16 - 1);
   subtype Sub_Float is Float range 1.0 .. 2.0 ** 17;
   cases : Integer;

   procedure main;

   procedure GetValues
     (cases : Sub_Int; sum : Sub_Int; count : Sub_Int);

   function DecreaseCase (cases : Sub_Int) return Integer with
      Pre  => cases > 0,
      Post => DecreaseCase'Result = cases - 1;

   function Increase (number : Sub_Int) return Integer;

   function sumValues (value : Sub_Int; sum : Sub_Int) return Integer;

   procedure PrintResult (cases : Sub_Int; result : Sub_Int);

   procedure HandleCases (cases : Sub_Int; sum : Sub_Int; count : Sub_Int);

   function DecreaseCase (cases : Sub_Int) return Integer is
   begin
      return cases - 1;
   end DecreaseCase;

   function Increase (number : Sub_Int) return Integer is
   begin
      if number + 1 in Sub_Int then
         return number + 1;
      else
         return 1;
      end if;
   end Increase;

   function sumValues (value : Sub_Int; sum : Sub_Int) return Integer is
   begin
      if value + sum in Sub_Int then
         return value + sum;
      else
         return 1;
      end if;
   end sumValues;

   procedure GetValues
     (cases : Sub_Int; sum : Sub_Int; count : Sub_Int) is
      value : Integer;
      newSum : Integer;
      newCount : Integer;
   begin
      Get (value);
      if value in Sub_Int then
         newSum := sumValues (value, sum);
         newCount := Increase (count);
         if value = 0 then
            if newSum in Sub_Int and newCount in Sub_Int then
               HandleCases (cases, newSum, newCount);
            end if;
         else
            if newSum in Sub_Int and newCount in Sub_Int then
               GetValues (cases, newSum, newCount);
            end if;
         end if;
      end if;
   end GetValues;

   procedure HandleCases (cases : Sub_Int; sum : Sub_Int; count : Sub_Int) is
      result : Integer;
      floatSum : Float;
      floatCount : Float;
      floatResult : Float;
   begin
      floatSum := Float (sum);
      floatCount := Float (count - 1);
      if floatSum in Sub_Float and floatCount in Sub_Float then
         floatResult := floatSum / floatCount;
         result := Integer (floatResult);
         PrintResult (cases, result);
      end if;
   end HandleCases;

   procedure PrintResult (cases : Sub_Int; result : Sub_Int) is
      newCase : Integer;
   begin
      if cases < 2 then
         Put (Item => result'Image);
      else
         Put (Item => result'Image);
         newCase := DecreaseCase (cases);
         GetValues (newCase, 0, 0);
      end if;
   end PrintResult;

   procedure main is
   begin
      Get (cases);
      if cases in Sub_Int then
         GetValues (cases, 0, 0);
      end if;
   end main;
begin
   main;
end alejo0xono;

--  cat DATA.lst | ./alejo0xono
--  2455 81 1058 647 223 450 1175 7449 6749 233
