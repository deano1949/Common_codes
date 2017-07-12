function mvcorrel=movingEWCorrel(x1,x2,T,decayrate)
%Calculate rolling exponential weighted correlation (EWMA Correlation)
%Input:
%   x1 and x2: return time series
%   t: time windows
%   dacayrate: (1-weighting of last observations)

ro=size(x1,1);

if T>ro
    error('time windows exceeds the size of time series');
end
var1=zeros(ro,1);var2=zeros(ro,1); covar=zeros(ro,1);

inicovar=cov(x1(1:T),x2(1:T));
var1(T)=inicovar(1,1);
var2(T)=inicovar(2,2);
covar(T)=inicovar(1,2)*(T-1)/T;

for t=1:(ro-T)
    xsqt1=x1(T+t); xsqt2=x2(T+t);
    var1(T+t)=var1(T+t-1)*decayrate+xsqt1^2*(1-decayrate);
    var2(T+t)=var2(T+t-1)*decayrate+xsqt2^2*(1-decayrate);
    covar(T+t)=covar(T+t-1)*decayrate+xsqt1*xsqt2*(1-decayrate);
end

mvcorrel=covar./((var1.*var2).^(0.5));
