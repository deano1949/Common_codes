function [rollSR,zscore,ret,numUnits,cumpnl] = RollingSR(x,t,zstype,YNStratPNL)
% Calculate rolling sharpe ratio over a time period and then standardise it
% Input: x: return series
%        t: time period
%        zstype:'full' or 'roll' Details please find in CalZscore.m
%        YNStratPNL: optional for output of strategy PNL 
% Output: Rolling Sharpe ratio signals (standardised)
%        rollSR: rolling Sharp ratio time series
%        zscore: of rolling Sharp ratio
%        ret: daily return of strategy
%        numUnits: number of units of buy and sell positions
%        cumpnl: cummulative pnl

%% Mainbody
rollSR= smartMovingAvg(x,t)./smartMovingStd(x,t);
%% calculate halflife/zscore
% zstype='full';
zscore= CalZscore(rollSR,zstype);
zscore(zscore>=2)=2; zscore(zscore<=-2)=-2; % cap signal at +/-2
%% plot
% srstd=ones(size(rollSR))*smartstd(rollSR);
% srma=ones(size(rollSR))*smartmean(rollSR);
% plot(rollSR);hold on; plot(srma+srstd); plot(srma-srstd); hold off;
% 
%% Strategy PNL
if nargin==4
    Threshold=1;
    ExitThreshold=0.02;
    longsEntry=zscore < -Threshold; % a long position means we should buy Y short X
    longsExit=zscore > -ExitThreshold;

    shortsEntry=zscore > Threshold;
    shortsExit=zscore < ExitThreshold;

    numUnitsLong=NaN(length(x), 1);
    numUnitsShort=NaN(length(x), 1);

    numUnitsLong(1)=0;
    numUnitsLong(longsEntry)=1; 
    numUnitsLong(longsExit)=0;
    numUnitsLong=fillMissingData(numUnitsLong); % backfill data with previous day's value

    numUnitsShort(1)=0;
    numUnitsShort(shortsEntry)=-1; 
    numUnitsShort(shortsExit)=0;
    numUnitsShort=fillMissingData(numUnitsShort);

    numUnits=numUnitsLong+numUnitsShort;
    ret=lag(numUnits, 1).*x; % daily P&L of the strategy
    ret(isnan(ret))=0;
    cumpnl=cumprod(1+ret)-1;
    % figure(2);
    % plot(cumpnl); % Cumulative compounded return
    % fprintf(1, 'APR=%f Sharpe=%f\n', prod(1+ret).^(252/length(ret))-1, sqrt(252)*mean(ret)/std(ret));
end
end