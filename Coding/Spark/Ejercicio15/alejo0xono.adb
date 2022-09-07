--  gnatprove -P/home/alejo/GNATstudio/first.gpr -j0 
--  --output=oneline --ide-progress-bar -u alejo0xono.adb --level=4
--  Phase 1 of 2: generation of Global contracts ...
--  Phase 2 of 2: flow analysis and proof ...
--  Summary logged in /home/alejo/GNATstudio/obj/gnatprove/gnatprove.out
--  [2022-08-31 22:36:11] process terminated successfully, elapsed time: 02.41s

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure alejo0xono with
   SPARK_Mode => ON
is

   number : Integer;

   procedure GetValues
     (cases : Integer; min : Integer; max : Integer);

   function MinOfTwo
     (firstNum : Integer; secondNum : Integer) return Integer;
   
   function MaxOfTwo
     (firstNum : Integer; secondNum : Integer) return Integer;

   function DecreaseCase (cases : in Integer) return Integer with
      Pre  => cases > (Positive'First),
      Post => DecreaseCase'Result = cases - 1;

   procedure PrintResult (min : Integer; max : Integer);

   function DecreaseCase (cases : in Integer) return Integer is
   begin
      return cases - 1;
   end DecreaseCase;

   procedure PrintResult (min : Integer; max : Integer) is
   begin
      Put (Item => max'Image);
      Put (" ");
      Put (Item => min'Image);
   end PrintResult;

   procedure GetValues
     (cases : Integer; min : Integer; max : Integer) is
      newCase : Integer;
      nextNumber : Integer;
      newMin : Integer;
      newMax : Integer;
   begin
      Get (nextNumber);
      newMin := MinOfTwo (min, nextNumber);
      newMax := MaxOfTwo (max, nextNumber);
      if cases in Integer and cases < 3 then
         PrintResult (newMin, newMax);
      else
         newCase := DecreaseCase (cases);
         GetValues (newCase, newMin, newMax);
      end if;
   end GetValues;

   function MinOfTwo
     (firstNum : Integer; secondNum : Integer) return Integer
   is
   begin
      if firstNum <= secondNum then
         return firstNum;
      else
         return secondNum;
      end if;
   end MinOfTwo;

   function MaxOfTwo
     (firstNum : Integer; secondNum : Integer) return Integer
   is
   begin
      if firstNum >= secondNum then
         return firstNum;
      else
         return secondNum;
      end if;
   end MaxOfTwo;

   procedure main;

   procedure main is
   begin
      Get (number);
      GetValues (300, number, number);
   end main;
begin
   main;
end alejo0xono;

--  cat DATA.lst | ./alejo0xono
--  78988 -79742
