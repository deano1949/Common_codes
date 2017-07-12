classdef financialdata
    %FINANCIALDATA Summary of this class goes here
    %   Detailed explanation goes here
    %example:
    %eurusd_2h=financialdata('4003','EUR/USD','USD','01/01/2012-31/10/2014','skip','market_data_1_EURUSD.txt','2H');
    properties 
        lmaxid
        symbol
        quoatedccy
        effectivedate
        frequency
        skipweekend
        timestmap
        openprice
        closeprice
        highprice
        lowprice
    end
    properties(Dependent)
        timept
        close_ret
    end
    
    methods
        function obj=financialdata(id,sym,ccy,effectdate,skweekend,textid,frequency)
            obj.lmaxid=id;
            obj.symbol=sym;
            obj.quoatedccy=ccy;
            obj.effectivedate=effectdate;
            obj.skipweekend=skweekend;
            obj.frequency=frequency;
            fileid=fopen(textid);
            result=textscan(fileid, '%s %s %f %f %f %f','HeaderLines',1, 'Delimiter',',');
            fclose(fileid);
            obj.timestmap = result{2};
            obj.openprice=result{3};
            obj.closeprice = result{4};
            obj.highprice=result{5};
            obj.lowprice = result{6};
        end
        
        function timept=get.timept(obj)
                timept=datenum(obj.timestmap);
        end
        function close_ret=get.close_ret(obj)
            close_ret=[NaN; price2ret(obj.closeprice)];
        end
    end
    
end

