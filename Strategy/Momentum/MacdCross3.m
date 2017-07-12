function [ret,signal]=MacdCross3(x,f1,f2,f3)
%Description: Momentum strategy, singal generates when short-term MA (f1)
%crosses both mid-term MA(f2) and long-term MA(f3)
%(1) Buy when crosses upward;
%(2) Sell when crosses downward;
%(3) no trade otherwise
%--------------------------
%Input: x: price time series
%       f1: short-term period
%       f2: mid-term period
%       f3: long-term period
%Output:    ret:    daily returns
%           signal: buy/sell signal
%%
mv1=smartMovingAvg(x,f1); %short-term moving average
mv2=smartMovingAvg(x,f2); %mid-term moving average
mv3=smartMovingAvg(x,f3); %long-term moving average

buysignal=mv1>=mv2 & mv2>=mv3;
sellsignal=-(mv1<=mv2 & mv2<=mv3);
signal=buysignal+sellsignal; %buy/sell signals

ret=lag(signal, 1).*(x-lag(x, 1))./lag(x, 1); % daily P&L of the strategy
ret(isnan(ret))=0;
pnl=cumprod(1+ret);
% fprintf(1, 'APR=%f Sharpe=%f\n', prod(1+ret).^(252/length(ret))-1, sqrt(252)*mean(ret)/std(ret));

