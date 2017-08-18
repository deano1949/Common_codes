function dat= table_removeNaN(dat)
%TABLE_REMOVENAN removes NaN from a table

if ~isa(dat,'table')
    error('class must be table, dude')
end

startpt=size(dat,1); %cutoff point
k=2;
for i=2:size(dat,2)
    ts1=table2array(dat(:,i));
    ts0=ts1(~isnan(ts1));
    [~,id]=ismember(ts0(1),ts1);
    if id<startpt
        startpt=id;
        k=i;
    end
end
dat=dat(startpt:end,:);

name=fieldnames(dat);
name2=name{k};
ts2=dat.(name2);col=size(ts2(~isnan(ts2)),1);

[~,ix]=ismember('x0',name);

if ix==0
    dat=dat(1:col,:);
else
    dat=dat(1:col,1:ix-1);
end


end

