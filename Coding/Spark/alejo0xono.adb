--  gprbuild alejo0xono.adb

with Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure ejemplo with
  SPARK_Mode => ON 
  is

  value: Integer;

  procedure main;
  procedure GetData (value: Integer);
  procedure sumData (firstNumber: Integer; secondNumber: Integer);

  procedure main is
  begin
    Ada.Integer_Text_IO.Get (Item => value);
    GetData(value);
  end main;

  procedure GetData (value: Integer) is
  newValue: Integer;
  firstNumber: Integer;
  secondNumber: Integer;
  begin
    Ada.Integer_Text_IO.Get (Item => firstNumber);
    Ada.Integer_Text_IO.Get (Item => secondNumber);
    if value = 1 then
      sumData (firstNumber, secondNumber);
    else
      newValue := (value) - 1;
      sumData (firstNumber, secondNumber);
      GetData(newValue);
    end if;
  end GetData;

  procedure sumData (firstNumber: Integer; secondNumber: Integer) is
     sum : Integer;
  begin
     sum := (firstNumber) + (secondNumber);
     Ada.Text_IO.Put (sum'Image);
  end sumData;

begin
  main;
end ejemplo;

--  cat DATA.lst | ./alejo0xono
