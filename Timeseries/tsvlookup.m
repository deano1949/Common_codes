function tsmat=tsvlookup(lookuptime,tstime,tsdata)
%Description: vlookup on the date of 'lookuptime vector' on [tstime tsdata]
%Input: lookuptime: time of new time series [datenum (it has to be
%datenum)]
%       tstime: time (must be in datenum)
%       tsdata: timeseries data
%Output: tsmat: lookuped time series

%%
tsmat=nan(size(lookuptime,1),size(tsdata,2)+1);
tsmat(:,1)=lookuptime;

[~,id]=ismember(tstime,lookuptime); id=id(id~=0);
[~,ik]=ismember(lookuptime,tstime); ik=ik(ik~=0);

ts=tsdata(ik); ts(isnan(ts))=0;
tsmat(id,2)=ts;
