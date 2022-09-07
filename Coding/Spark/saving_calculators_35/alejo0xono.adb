-- gprbuild alejo0xono.adb

with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;

procedure alejo0xono with
  SPARK_Mode => ON
  is

  procedure main;
  procedure GetValues (cases: Integer);
  procedure GetYear 
  (money: Float; required: Integer; rate: Integer; year: Integer);

  procedure main is
    cases: Integer;
  begin
    Ada.Integer_Text_IO.Get (Item => cases);
    GetValues(cases);
  end main;

  procedure GetValues (cases: Integer) is
    money: Integer;
    required: Integer;
    rate: Integer;
    newCases: Integer;
    newMoney: Float;
  begin
    Ada.Integer_Text_IO.Get (Item => money);
    Ada.Integer_Text_IO.Get (Item => required);
    Ada.Integer_Text_IO.Get (Item => rate);
    newCases := cases - 1;
    newMoney := Float(money);
    if newCases = 0 then
      GetYear(newMoney, required, rate, 0);
    else
      GetYear(newMoney, required, rate, 0);
      GetValues(newCases);
    end if;
  end GetValues;

  procedure GetYear 
  (money: Float; required: Integer; rate: Integer; year: Integer) is
    newMoney: Float;
    newYear: Integer;
    sum: Integer;
    newrequired: Integer;
  begin
    newMoney := money + (money * Float(Float(rate) / 100.0));
    sum := newrequired + (rate * i);
    newYear := i + 1;
    if required = rate then
      result := (Float (money) / 2.0);
      Ada.Float_Text_IO.Put (result);
      else
      if sum > money then
        result := (Float (money - sumBefore) / Float (sum - sumBefore)) 
        + Float(required * (i - 1));
        Ada.Float_Text_IO.Put (result);
      elsif sum = money then
        Ada.Text_IO.Put (newrequired'Image);
      else
        GetYear(money, required, rate, sum, newI);
      end if;
    end if;
  end GetYear;

begin
  main;
end alejo0xono;

-- cat DATA.lst | ./alejo0xono
-- 2455 81 1058 647 223 450 1175 7449 6749 233
