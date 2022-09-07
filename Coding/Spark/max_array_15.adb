--  gnatprove -P/home/alejo/GNATstudio/alejo0xono.gpr -j0 --output=oneline
--  --ide-progress-bar --mode=check_all
--  Phase 1 of 2: generation of Global contracts ...
--  Phase 2 of 2: full checking of SPARK legality rules ...
--  Summary logged in /home/alejo/GNATstudio/obj/gnatprove/gnatprove.out
--  [2022-08-25 16:42:15] process terminated successfully, elapsed time: 01.69s
--  gprbuild -ws -c -f -u 
--  -P/home/alejo/GNATstudio/alejo0xono.gpr alejo0xono.adb

with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.IO_Exceptions;

procedure ejemplo with
  SPARK_Mode => ON
is

   procedure main;
   procedure findNumbers (max : Integer; min : Integer; i : Integer) with
      Pre => (i >= 1 and i <= 301)
               and then (max) < Integer'Last - 50 * 100000
               and then (min) < Integer'Last - 50 * 100000;

   procedure findNumbers (max : Integer; min : Integer; i : Integer) is
      nextNumber : Integer;
      newMin : Integer;
      newI : Integer;
   begin
      Ada.Integer_Text_IO.Get (Item => nextNumber);
      newI := i + 1;
      if newI = 300 then
         Ada.Text_IO.Put (max'Image);
         Ada.Text_IO.Put (" ");
         Ada.Text_IO.Put (min'Image);
      else
         if max >= nextNumber then
            if nextNumber >= min then
               findNumbers (max, min, newI);
            else
               newMin := nextNumber;
               findNumbers (max, newMin, newI);
            end if;
         else
            if max >= min then
               findNumbers (nextNumber, min, newI);
            else
               findNumbers (nextNumber, max, newI);
            end if;
         end if;
      end if;
   end findNumbers;

   procedure main is
      value : Integer;
   begin
      Ada.Integer_Text_IO.Get (Item => value);
      findNumbers (value, value, 1);
   end main;

begin
   main;
end ejemplo;

--  cat DATA.lst | ./alejo0xono
--  78988 -79742