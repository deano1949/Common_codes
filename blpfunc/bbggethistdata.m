function fulldat=bbggethistdata(name,field,fromdate,todate,period,currency)
c=blp;
% javaaddpath('F:\MATLAB\blpapi3.jar');

%specific values

    per={period,'non_trading_weekdays','previous_value'};
    [dat,secname]=history(c,name,field,fromdate,todate,per,currency);

    namesz=length(name);
    if ischar(name)
        namesz=1;
    end
    
    fldsz=length(field);

    fulldat=struct;
    %get master timestamp
    try
        sec1=dat{1};
        timestamp=datestr(sec1(:,1),'dd/mm/yyyy');
    catch
        timestamp=datestr(dat(:,1),'dd/mm/yyyy');
    end

mastertime=datenum(timestamp,'dd/mm/yyyy');
    for i=1:fldsz
        sectable=table;
        for j=1:namesz
            try
                sects=dat{j};
                [~,id]=ismember(mastertime,sects(:,1));
                if ismember(0,id) %treatment for timestamp not available in mastertime
                    id2=backshift(1,id);
                    id(id==0)=id2(id==0);
                    id(isnan(id))=id(2);
                end
                sects=sects(id,i+1);
            catch
               sects=dat(:,i+1); %works for single security download
            end
            Nm=char(secname(j));
            Nm=strrep(Nm,' ','_');
            Nm=strrep(Nm,'/','_');
            Nm=strrep(Nm,'*','_');
            Nm=strrep(Nm,'&','_');
            Nm=strrep(Nm,'-','_');
      try
                  sectable.(Nm)=sects;
      catch
          Nm = strcat('BBG',Nm); % added BBG to front of ticker
          sectable.(Nm)=sects;

      end          

        end
        fulldat.(char(field(i)))=sectable;
    end
    fulldat.timestamp=timestamp;
    close(c);
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
