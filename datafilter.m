classdef datafilter
    %DATAFILTER3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        instrument
        classtype
        currency
        timestart
        timeend
        time_seq
        ret    
        close_price
        open_price
        high_price
        low_price
        data
        zsdata
    end
    
%     properties (Dependent)
%         findata2mat %O/L/H/C
%     end
    methods
    %% objfilter    
        function obj=datafilter(findata,starttime,endtime,format)
            %obj=obj@financialdata(findata{:});
            if isa(findata,'returndata')
                obj.classtype='returndata';
                obj.currency=findata.currency;
                obj.timestart=starttime;
                obj.timeend=endtime;

                %get filtered data
                startstr=datenum(starttime,format);
                endstr=datenum(endtime,format);
                timept=datenum(findata.dateid,format);
                p=floor(timept);
                %descending or ascending
                if timept(1)>timept(2)
                    firstpt0=find(p>=startstr,1,'last');
                    lastpt0=find(p<=endstr,1,'first');
                else
                    firstpt0=find(p>=startstr,1,'first');
                    lastpt0=find(p<=endstr,1,'last');
                end
                if firstpt0>lastpt0
                    firstpt=lastpt0;
                    lastpt=firstpt0;
                else
                    firstpt=firstpt0;
                    lastpt=lastpt0;
                end
                if isempty(firstpt) || isempty(lastpt)
                    disp('invalid start date or end date');
                else
                obj.time_seq=findata.dateid(firstpt:lastpt);
                obj.data=findata.data(firstpt:lastpt,:);
                obj.zsdata=findata.zsdata(firstpt:lastpt,:);
                obj.close_price=[];
                obj.open_price=[];
                obj.high_price=[];
                obj.low_price=[];
                end
            
            
            elseif isa(findata,'financialdata')
                obj.classtype='financialdata';
                obj.instrument=findata.symbol;
                obj.currency=findata.quoatedccy;
                obj.timestart=starttime;
                obj.timeend=endtime;
                %get filtered data
                startstr=datenum(starttime,format);
                endstr=datenum(endtime,format);
                timept=datenum(findata.timestmap,format);
                p=floor(timept);
                %descending or ascending
                if timept(1)>timept(2)
                    firstpt0=find(p>=startstr,1,'last');
                    lastpt0=find(p<=endstr,1,'first');
                else
                    firstpt0=find(p>=startstr,1,'first');
                    lastpt0=find(p<=endstr,1,'last');
                end
                if firstpt0>lastpt0
                    firstpt=lastpt0;
                    lastpt=firstpt0;
                else
                    firstpt=firstpt0;
                    lastpt=lastpt0;
                end
                if isempty(firstpt) || isempty(lastpt)
                    disp('invalid start date or end date');
                else
                obj.time_seq=findata.timept(firstpt:lastpt);
                obj.ret=findata.close_ret(firstpt:lastpt);
                obj.close_price=findata.closeprice(firstpt:lastpt);
                obj.open_price=findata.openprice(firstpt:lastpt);
                obj.high_price=findata.highprice(firstpt:lastpt);
                obj.low_price=findata.lowprice(firstpt:lastpt);
                end
                
            else
                error(message('inputclass must be financialdata or returndata'));
            
            end
            
        end
        

        
    end
        
end

