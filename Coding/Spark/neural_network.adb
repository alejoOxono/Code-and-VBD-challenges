--  gprbuild alejo0xono.adb

with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Exceptions;
with Ada.IO_Exceptions;

procedure ejemplo with
  SPARK_Mode => ON
  is

  procedure main;
--    procedure GetFirstLine (flag: Integer);

  procedure main is
    value: Integer;
  begin
    Ada.Integer_Text_IO.Get (Item => value);
    Ada.Text_IO.Put (value'Image);
    Ada.Text_IO.Put (" ");
    main;
    exception
      when E : ADA.IO_EXCEPTIONS.END_ERROR =>
         Ada.Text_IO.Put ("holdad2as!");
  end main;

--    procedure GetData (value: Integer) is
--      newValue: Integer;
--      firstNumber: Integer;
--      secondNumber: Integer;
--    begin
--      Ada.Integer_Text_IO.Get (Item => firstNumber);
--      Ada.Integer_Text_IO.Get (Item => secondNumber);
--      if value = 1 then
--        sumData (firstNumber, secondNumber);
--      else
--        newValue := (value) - 1;
--        sumData (firstNumber, secondNumber);
--        GetData(newValue);
--      end if;
--    end GetData;

begin
  main;
end ejemplo;

--  cat DATA.lst | ./alejo0xono
-- 0.42505377714249 0.43526193952425 -0.11860480318619 -0.029998130065869 
-- 0.33038800438358 0.43208983417744 -0.7983671778839 0.41324248156832 -0.27323024695796 
-- -0.26911352859421 0.61598978052753 -0.21236951801883 -0.28925392351555 -0.34792691824998
-- 0.76381963871387 -0.36903714019 0.16288665177381 0.15769507071914 -0.23240818108117 
-- 0.076727785321774 -0.18768322603182 -0.21715712687356 -0.072711906104577 0.025110746827684
