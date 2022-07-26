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
  
  fun {TypeTriangle Row}
    local
      List = {String.tokens {Row getS($)} & }
      CleanData = {Map List String.toFloat}
      Hypotenuse = {Nth CleanData 3} * {Nth CleanData 3}
      LegTwo = {Nth CleanData 2} * {Nth CleanData 2}
      LegOne = {Nth CleanData 1} * {Nth CleanData 1}
      RightH = "R"
      Acute = "A"
      Obtuse = "O"
    in
      if Hypotenuse > LegOne + LegTwo
      then Obtuse
      elseif Hypotenuse < LegOne + LegTwo
      then Acute
      else RightH
      end
    end
  end
    
  proc {Print Ncases Data}
    local
      Resolve = {TypeTriangle Data}
    in
      {System.printInfo Resolve}
      {System.printInfo " "}
      if Ncases > 2
      then
        {Print Ncases - 1 Data}
      else
        {System.printInfo {TypeTriangle Data}}
      end
    end
  end
in
  {GetData}
  {Print Ncases Data}
  {Application.exit 0}
end
end