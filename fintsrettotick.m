function fts=fintsrettotick(fintimeseries)
% calculate ret2tick for fints and remove NaN in time series

finarray=fts2mat(fintimeseries);
finarray(isnan(finarray))=0;
finarray=ret2tick(finarray);
finarray=finarray(2:end,:);
fts=fints(fintimeseries.dates,finarray);