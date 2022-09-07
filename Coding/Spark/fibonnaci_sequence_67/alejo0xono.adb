-- gprbuild alejo0xono.adb
pragma Ada_2020;

with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Numerics.Big_Numbers.Big_Integers;
use  Ada.Numerics.Big_Numbers.Big_Integers;

procedure alejo0xono with
  SPARK_Mode => ON
  is
  
  procedure main;
  procedure GetValues (cases: Integer);
  --  procedure GetIndices
  --  (fibboNum: Big_Integer; before: Big_Integer; sum: Big_Integer; indice: Integer);

  procedure main is
    cases: Integer;
  begin
    Ada.Integer_Text_IO.Get (Item => cases);
    GetValues(cases);
  end main;

  procedure GetValues (cases: Integer) is
    inNumber: Big_Integer;
    newCases: Integer;
    data: String(1..211);
  begin
    Ada.Text_IO.Get (Item => data);
    inNumber := From_String(data);
    newCases := cases - 1;
    if newCases = 0 then
        Ada.Text_IO.Put (inNumber'Image);
      --  GetIndices(inNumber, 1, 1, 2);
    else
        Ada.Text_IO.Put (inNumber'Image);
      --  GetIndices(inNumber, 1, 1, 2);
      GetValues(newCases);
    end if;
  end GetValues;

  --  procedure GetIndices
  --  (fibboNum: Big_Integer; before: Big_Integer; sum: Big_Integer; indice: Integer) is
  --    newIndice: Integer;
  --    fibboActual: Big_Integer;
  --  begin
  --    fibboActual := sum + before;
  --    newIndice := indice + 1;
  --    case fibboNum is
  --      when 0 =>
  --        Ada.Text_IO.Put (fibboNum'Image);
  --      when 1 =>
  --        Ada.Text_IO.Put (fibboNum'Image);
  --      when others =>
  --        if fibboNum = fibboActual then
  --          Ada.Text_IO.Put (newIndice'Image);
  --        else
  --          GetIndices(fibboNum, sum, fibboActual, newIndice);
  --        end if;
  --    end case;
  --  end GetIndices;

begin
  main;
end alejo0xono;

-- cat DATA.lst | ./alejo0xono
-- 2455 81 1058 647 223 450 1175 7449 6749 233
