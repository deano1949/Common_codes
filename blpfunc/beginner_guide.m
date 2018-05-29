%% History data

%   'daily' - daily
%   'weekly' - weekly
%   'monthly' - monthly
%   'quarterly' - quarterly
%   'semi_annually' - semi annually
%   'yearly' - yearly
%   'actual' - anchor date specification
%   'calendar' - anchor date specification 
%   'fiscal' - anchor date specification
%   'non_trading_weekdays' - non trading weekdays
%   'all_calendar_days' - return all calendar days
%   'active_days_only' - active trading days only
%   'previous_value' - fill missing values with previous values
%   'nil_value' - fill missing values with NaN
%
%   For example, PER = {'daily','calendar'} returns daily data for all calendar days
%   reporting missing data as NaN's. PER = {'actual'} returns the data using
%   the default periodicity and default calendar reporting missing data as
%   NaN's.  Note that the anchor date is dependent on the TODATE input
%   argument.  

secname={'BAC US Equity' 'VOD LN Equity'};
fromdate='01/01/2000';
todate='03/30/2017';
field={'PX_LAST' 'PX_OPEN'};
period='daily';
currency=[];

dat=bbggethistdata(secname,field,fromdate,todate,period,currency);

%% get static data as bulk
dat2=getbulkdata(c,secname,field,'DATE','20170329');

dmat=cell2mat(dat(1));

%% Current data
[d,sec] = getdata(c,{'MSFT US Equity' 'BAC US Equity'},{'LAST_PRICE';'OPEN'});