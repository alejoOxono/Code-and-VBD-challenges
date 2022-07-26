% ozc -c alejo0xono.oz

functor
import
  System
  Application
  Open

define
local
  Ncases
  Data

  proc {GetData}
    local
      class InputData from Open.file Open.text end
    in
      Data = {New InputData init(name:stdin)}
      Ncases = {String.toInt {Data getS($)}}
    end
  end

  fun {GetHeight Row}
    local
      List = {String.tokens {Row getS($)} & }
      CleanData = {Map List String.toFloat}
      Distance = {Nth CleanData 1}
      Angle = ({Nth CleanData 2} - 90.0)* 3.1416 / 180.0
      Tangente = {Float.tan Angle}
      Result = {Float.toInt {Float.round Tangente * Distance}}
    in
      Result
    end
  end

  proc {Print Ncases Data}
    local
      Resolve = {GetHeight Data}
    in
      {System.printInfo Resolve}
      {System.printInfo " "}
      if Ncases > 2
      then
        {Print Ncases - 1 Data}
      else
        {System.printInfo {GetHeight Data}}
      end
    end
  end
in
  {GetData}
  {Print Ncases Data}
  {Application.exit 0}
end
end

% cat DATA.lst | ozengine alejo0zono.ozf
% 64 30 61 49 48 30 19 67 36 17 29 37 33 34 25
