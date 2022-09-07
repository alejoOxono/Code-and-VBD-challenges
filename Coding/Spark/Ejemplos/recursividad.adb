with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.IO_Exceptions; use Ada.IO_Exceptions;

procedure main with SPARK_Mode is

   type Nat is new Natural;

   valor : Integer;
   valor2 : Nat;
   result : Nat;
   
   procedure PrintCases (P : Nat);
   
   function "+" (X, Y : Nat) return Nat is
     (if X > Nat'Last - Y then Nat'Last else X + Y);

   --  function Fibonacci (N : Nat) return Nat is
   --    (if N = 0 then 0
   --     elsif N = 1 then 1
   --     else Fibonacci (N - 1) + Fibonacci (N - 2))
   --  with Subprogram_Variant => (Decreases => N);

   function Fibonacci (N : Nat) return Nat 
   with Subprogram_Variant => (Decreases => N)
   is
   begin
      PrintCases (N);
      if N = 0 then 
         return 0;
      elsif N = 1 then 
         return 1;
      else 
         return (Fibonacci (N - 1));
      end if;
   end Fibonacci;
   
   procedure PrintCases (P : Nat) is
   begin
      Put (Item => P'Image);
   end PrintCases;
   
begin
   Get (Item => valor);
   valor2 := Nat(valor);
   result := Fibonacci(valor2);
   Ada.Text_IO.Put (result'Image);
end main;