function fts=fintsconvt(fintimeseries,datatype,freqtype)
%It converts daily frequency of financial time series into weekly/monthly
%frequency. with different types: return time series and price time series
% INPUT: fintimeseries: financial time series
%        datatype: 'ret' or 'price'
%        freqtype: 'toweekly','tomonthly'
% OUTPUT: fts: output time series

if strcmp(datatype,'ret')
    fintimeseries=fintsrettotick(fintimeseries);
    if strcmp(freqtype,'toweekly')
        TS=toweekly(fintimeseries);
        fts=tick2ret(TS);
    elseif strcmp(freqtype,'tomonthly')
        TS=tomonthly(fintimeseries);
        fts=tick2ret(TS);
    end
elseif strcmp(datatype,'price')
    if strcmp(freqtype,'toweekly')
        fts=toweekly(fintimeseries);
    elseif strcmp(freqtype,'tomonthly')
        fts=tomonthly(fintimeseries);
    end
end

