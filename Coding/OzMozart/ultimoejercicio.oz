% ozc -c alejo0xono.oz

functor
import
  System Application Open
define
  local
  Data

  proc {GetData}
    local
      class InputData from Open.file Open.text end
    in
      Data = {{New InputData init(name:stdin)} getS($)}
    end
  end

  fun {StepsCount Data Step}
    local
      FirstEl = Data.1
      SecondEl = Data.2
    in
      if FirstEl == 49
      then
        if SecondEl.1 == 48
        then
          if SecondEl.2 == nil
          then
            Step#' '
          else
            {StepsCount
            {MapBinary FirstEl SecondEl 1}
            Step + 1}
          end
        else
          {StepsCount
          {MapBinary FirstEl SecondEl 1}
          Step + 1}
        end
      else
        {StepsCount
        {MapBinary FirstEl SecondEl 1}
        Step + 1}
      end
    end
  end

  fun {MapBinary FirstEl SecondEl Contador}
    if SecondEl == nil
    then
      {VirtualString.toString
      {DecimalBinary Contador '' 1}}
    else
      if FirstEl == SecondEl.1
      then
        {MapBinary SecondEl.1
        SecondEl.2 Contador + 1}
      else
        {VirtualString.toString
        {DecimalBinary Contador '' 1}#
        {MapBinary SecondEl.1 SecondEl.2 1}}
      end
    end
  end

  fun {GetParents FirstEl SecondEl ParentsOne}
    if SecondEl == nil
    then
      {Number.pow 2 ParentsOne}
    else
      if FirstEl == 49
      then
        {GetParents SecondEl.1
        SecondEl.2
        ParentsOne + 1}
      else
        {GetParents SecondEl.1
        SecondEl.2
        ParentsOne}
      end
    end
  end

  fun {DecimalBinary Contador Binary Control}
    local
      Combined
    in
      if Contador div 2 == 0
      then
        if Control > 1
        then
          1#Binary
        else
          1
        end
      else
        if Binary == ''
        then
          {DecimalBinary Contador div 2 {Int.'mod' Contador 2}
          Control + 1}
        else
          Combined = {Int.'mod' Contador 2}#Binary
          {DecimalBinary Contador div 2 Combined Control + 1}
        end
      end
    end
  end

  in
    {GetData}
    {System.printInfo {StepsCount Data 0}}
    {System.printInfo {GetParents Data.1 Data.2 0}}
    {Application.exit 0}
  end
end

% cat DATA.lst | ozengine alejo0zono.ozf
% 18 2305843009213693952
