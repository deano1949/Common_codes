function [tsfin,tstable] = reqHistData(id,contract,enddate,duration,freq,datatype,plotYN)

%% example: id=1000002
% contract=FuturesContract (predefined)
% endate='20171230 16:00:00'
% duration='1 Y','1 M','1 W' or '1 D'
% freq='5 mins','1 hour','2 hours','1 day','1 week'  or '1 month'
% datatype='TRADES' or 'MIDPOINT'
% plotYN= 'Y' or 'N'
%%
session = TWS.Session.getInstance();
[buf,lh] = TWS.initBufferForEvent(TWS.Events.HISTORICALDATA);
% session.eClientSocket.eConnect('127.0.0.1',7496,0);

session.eClientSocket.reqHistoricalData(id,contract,enddate,duration,freq,datatype,1,1,[]); 
pause(5);

%% Process historical data event
%
% Under the hood, Trader Workstation returns one bar at a time.  That is, EWrapper:historicalData() is
% called once for each bar.  Each bar associated with the request ID, 1000001 in this case, is aggregated
% into a single event (i.e. event.data = HashSet<com.tws.Bar>)

%% 
% Retreive the historical data event from the buffer
hde = buf.get();

%% 
% Convert the HashSet<Bar> into more native cell array of bars
bars = collection2cell(hde.data);

%%
% Figure out how many bars were returned
numel(bars)

%% 
% but could also call size() method on event.data directly without cell conversion
numel(bars) == hde.data.size();

%%
% Print out bars to the screen
for i = 1:min(numel(bars),10); disp(bars{i}); end

%%
% Extract close and volume info from each bar
close = cellfun(@(b)b.close,bars);  
vol = cellfun(@(b)b.volume,bars);
open = cellfun(@(b)b.open,bars);
high=cellfun(@(b)b.high,bars);
low=cellfun(@(b)b.low,bars);

%% 
% Convert the string time of the bars to matlab datenum
dt = datenum(cellfun(@(b)char(b.dtstr),bars,'UniformOutput',false),'yyyymmdd HH:MM:SS');

%%
% The bars might not be in order once extracted from the HashSet
[~,indx] = sort(dt);

%% 
% create financial time series
tsfin=fints(dt(indx),[open(indx),high(indx),low(indx),close(indx), vol(indx)],{'open','high','low','close','volume'});

tsmat=[open(indx),high(indx),low(indx),close(indx), vol(indx)];
tstable=array2table(tsmat,'VariableNames',{'open','high','low','close','volume'});
tstable=horzcat(table(datestr(dt(indx),'dd/mm/yyyy HH:MM:SS'),'VariableNames',{'Date'}),tstable);

%% plot the data

if strcmp(plotYN,'Y')
    subplot(5,1,1:3); plot(dt(indx),close(indx),'Marker','.'); xlim([min(dt),max(dt)]); datetick; grid on; ylabel('close' );
    subplot(5,1,4:5); bar (dt(indx),vol  (indx)             ); xlim([min(dt),max(dt)]); datetick; grid on; ylabel('volume');
end


end

