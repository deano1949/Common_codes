function [zscore,halflife]= CalZscore(x,type,overwritetype,score)
%CALZscore calculates Z-score of strategy
% Two types: 'full': calculate Zscore of a full period
%            'roll': calculate Zscore on rolling basis (no lookahead bias)
%            'overwritetype: you can overwrite Halflife by entering 'HF'
%            and enter 'score' for overwrite value.
%INPUT: x: time series/signals
%       type:'full' or 'roll'
%OUTPUT: Zscore: Z-score
%%
sz=size(x,1);

isGoodData=find(isfinite(x));
x=x(isGoodData);
xlag=lag(x, 1);  
deltax=x-xlag; %difference

deltax(1)=[]; 
xlag(1)=[];
x(1)=[];
if strcmp(type,'full')
    regress_results=ols(deltax, [xlag ones(size(xlag))]);%autocorrelation regression
    if nargin<=2
        halflife=-log(2)/regress_results.beta(1);
    elseif strcmp(overwritetype,'HF')
        halflife=score;
    end
    lookback=round(halflife);
    srstd=smartMovingStd(x,lookback); %calculate x days moving standard deviation
    zscore=(x-smartMovingAvg(x,lookback))./srstd;
elseif strcmp(type,'roll')
    period=500;
    zscore=nan(size(x));
    for i=period:size(x)
        i
        regress_results=ols(deltax(1:i), [xlag(1:i) ones(i,1)]);
        halflife=-log(2)/regress_results.beta(1);
        lookback=round(halflife);
        LB(i)=lookback;
        srstd=smartstd(x(i-lookback:i));
        zscore(i)=(x(i)-smartmean(x(i-lookback:i)))./srstd;
    end
end

zscore=[NaN(sz-size(x,1),1);zscore]; %bring size of zscore to the same size as signal
end

