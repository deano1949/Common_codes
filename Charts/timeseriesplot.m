function timeseriesplot(x,datets,factname) 
%  x is vector
%  datets is date string
% factors' name
[~,c]=size(x);
for i=2:c;
datets1=datestr((datenum(cell2mat(datets),'dd/mm/yyyy')));
ts1 = timeseries(x(:,i),datets1);
ts1.TimeInfo.Format = 'dd/mm/yyyy'; % Set format for display on x-axis.
ts1.Name = factname{i+1};
subplot(4,5,i-1); 
plot(ts1);
ylim([-0.5,2]);
figure(gcf)
end



