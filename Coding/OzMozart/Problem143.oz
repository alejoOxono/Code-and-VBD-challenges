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

  proc {CasesManager Ncases Data}
    {Print Data}
    if Ncases > 2
    then
      {CasesManager Ncases - 1 Data}
    else
      {Print Data}
    end
  end

  proc {Print Row}
    local
      List = {String.tokens {Row getS($)} & }
      CleanData = {Map List String.toInt}
      Numero1 = {Nth CleanData 1}
      Numero2 = {Nth CleanData 2}
      Q = Numero1 div Numero2
    in
      {System.printInfo {GetGcd Numero1 Numero2}#' '}
      {ResultPrint Numero1 Numero2 1 0 0 1 Q}
    end
  end

  fun {GetGcd Numero1 Numero2}
    (Numero1 * Numero2) div ({GetLcm Numero1 Numero2 1 1})
  end

  fun {GetLcm Numero1 Numero2 Multi1 Multi2}
    if Numero1 * Multi1 == Numero2 * Multi2
    then
      Numero1 * Multi1
    elseif Numero1 * Multi1 < Numero2 * Multi2
    then
      {GetLcm Numero1 Numero2 Multi1+1 Multi2}
    else
      {GetLcm Numero1 Numero2 Multi1 Multi2+1}
    end
  end

  proc {ResultPrint Numero1 Numero2 Sprev Scur Tprev Tcur Q}
    local
      Modulo = {Int.'mod' Numero1 Numero2}
    in
      if Modulo == 0
      then
        {System.printInfo Scur#' '#Tcur#'\n'}
      else
        {ResultPrint Numero2 
        Modulo
        Scur
        Sprev - (Q * Scur)
        Tcur
        Tprev - (Q * Tcur)
        Numero2 div Modulo}
      end
    end
  end

in
  {GetData}
  {CasesManager Ncases Data}
  {Application.exit 0}
end
end

% cat DATA.lst | ozengine alejo0zono.ozf
%1 17872 -5789
%1 -3399 24238
%2 -18088 4353
%9 556 -1795
%1 -2922 2887
%1 21835 -10679
%1 -24482 26609
%1 -6184 7755
%33 608 -993
%3 584 -429
%7 3727 -2091
%1 25249 -18762
%1 -5783 6004
%2 1069 -1693
%1 120 -169
%1 25008 -7331
%29 769 -1493
%1 -1240 4393
%4 8697 -3854
%2 -4180 4813
%1 -23433 4540
%3 255 -107
%1 -6531 1985
%2 6046 -6693
%18 1222 -381
