-- gprbuild alejo0xono.adb

with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;

procedure alejo0xono with
  SPARK_Mode => ON
  is

  procedure main;
  procedure GetValues (cases: Integer);
  procedure GetDistance 
  (distance: Integer; cyclistOne: Integer;
  cyclistTwo: Integer; sumBefore: Integer; i: Integer);

  procedure main is
    cases: Integer;
  begin
    Ada.Integer_Text_IO.Get (Item => cases);
    GetValues(cases);
  end main;

  procedure GetValues (cases: Integer) is
    distance: Integer;
    cyclistOne: Integer;
    cyclistTwo: Integer;
    newCases: Integer;
  begin
    Ada.Integer_Text_IO.Get (Item => distance);
    Ada.Integer_Text_IO.Get (Item => cyclistOne);
    Ada.Integer_Text_IO.Get (Item => cyclistTwo);
    newCases := cases - 1;
    if newCases = 0 then
      GetDistance(distance, cyclistOne, cyclistTwo, 0, 1);
    else
      GetDistance(distance, cyclistOne, cyclistTwo, 0, 1);
      GetValues(newCases);
    end if;
  end GetValues;

  procedure GetDistance 
  (distance: Integer; cyclistOne: Integer;
  cyclistTwo: Integer; sumBefore: Integer; i: Integer) is
    result: Float;
    sum: Integer;
    newI: Integer;
    newCyclistOne: Integer;
  begin
    newCyclistOne := (cyclistOne * i);
    sum := newCyclistOne + (cyclistTwo * i);
    newI := i + 1;
    if cyclistOne = cyclistTwo then
      result := (Float (distance) / 2.0);
      Ada.Float_Text_IO.Put (result);
      else
      if sum > distance then
        result := (Float (distance - sumBefore) / Float (sum - sumBefore)) 
        + Float(cyclistOne * (i - 1));
        Ada.Float_Text_IO.Put (result);
      elsif sum = distance then
        Ada.Text_IO.Put (newCyclistOne'Image);
      else
        GetDistance(distance, cyclistOne, cyclistTwo, sum, newI);
      end if;
    end if;
  end GetDistance;

begin
  main;
end alejo0xono;

-- cat DATA.lst | ./alejo0xono
-- 2455 81 1058 647 223 450 1175 7449 6749 233
