function Ret = VoladjReturn(x,t,TargetVol)
%VOLADJRETURN produces volatility standardised return with target
%volatility
%------------------------------
%INPUT: x: return time series
%       t: time window for standardisation
%       TargetVol: target volatility of output return
%OUTPUT: Ret: volatility adjusted return time series
%        price: price time series

%%
vol=smartMovingStd(x,t);
Ret=x./vol*TargetVol;    



end

