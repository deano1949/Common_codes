classdef returngly
    %RETURNGENERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        timestmap
        ret0
        forecast_length
        Future_returns
        His_return_length
        His_return
        Gap_ret_info
        Gap_ret
        ret2lol
        ret2hoh
    end
    
    methods
        function obj=returngly(datafilter,k,x,y,z) %datafilter must be a datafilter class object
            if ~isa(datafilter,'datafilter')
                error('datafilter must be a datafilter object')
            end
         if nargin == 2 || nargin==5
            obj.timestmap=datafilter.time_seq;
            obj.forecast_length=['Future return of ' num2str(k) ' bars']; %forecast k bars later
%Get forecast return
            rett=datafilter.ret_filtered;
            obj.ret0=rett;
            kbars_price=datafilter.close_price_filtered(k+1:end);
            Future_ret=kbars_price./datafilter.close_price_filtered(1:end-k)-1;
            obj.Future_returns=[Future_ret;ones(k,1)];
%return to Highpoint/Lowpoint
            fullmatt=datafilter.findata2mat;
            for i=1:length(rett)-k
                matt=fullmatt(i:i+k,:);
                [ret2loll(i),ret2hohh(i),~]=returngly.xtremeret(matt);
            end
            nan_seq=nanm([1 k+1],[1 2],1);
            obj.ret2lol=[ret2loll'; nan_seq];
            obj.ret2hoh=[ret2hohh'; nan_seq];
                 if nargin ==5   
        %Get historical return
                    for i=1:x
                        retx(:,i)=rett(x-i+1:end-i+1);
                    end
                    Hisret=(prod(1+retx')-1)';
                    nan_seqx=nanm([1 x],[1 2],1);
                    obj.His_return_length=['Historical return of ' num2str(x) ' bars'];
                    obj.His_return=vertcat(nan_seqx,Hisret);
        %Get gap return
                    obj.Gap_ret_info=['Historical returns of ' num2str(y) ' bars at ' num2str(z) ' bars before']; 
                    for i=1:y
                        retgap(:,i)=rett(y-i+1:end-i+1);
                    end
                    nan_seqyz=nanm([1 y+z],[1 2],1);
                    Gapret=(prod(1+retgap')-1)';    
                    Gap_ret_ybars=vertcat(nan_seqyz,Gapret);
                    obj.Gap_ret=Gap_ret_ybars(1:end-z);
                 end
                 
                 
         else error('incorrect number of input arug')
         end  

        end
    end
       
     methods (Static = true)
%%     Claculate historical x bars of returns
        function His_return_xbars=his_ret(retdata,x) %retdata as vector
            reth=retdata;
            for i=1:x
                ret(:,i)=reth(x-i+1:end-i+1);
            end
            Hisret=(prod(1+ret')-1)';
            nan_seqx=nanm([1 x],[1 2],1);
            His_return_xbars=vertcat(nan_seqx,Hisret);
        end
%%       Calculate  historical y bars of returns before z bars   
        function Gap_ret_ybars=gap_ret(retdata,z,y) %retdata as vector
            for i=1:y
                retgap(:,i)=retdata(y-i+1:end-i+1);
            end
            Gapret=(prod(1+retgap')-1)';
            nan_seqx=nanm([1 y+z],[1 2],1);
            Gap_ret_ybars=vertcat(nan_seqx,Gapret);
            Gap_ret_ybars=Gap_ret_ybars(1:end-z);
        end
        
%%       Calculate the return to highest and lowest within next x bars
         function [ret2lol,ret2hoh,order]=xtremeret(matt)
             %matt=financialdata.findata2mat (O/L/H/C); k windows later;
             lol=min(matt(2:end,2)); 
             hoh=max(matt(2:end,3));
             ret2lol=lol/matt(1,4)-1; ret2hoh=hoh/matt(1,4)-1;
             [~,lolpos]=ismember(lol,matt(2:end,2)); [~,hohpos]=ismember(hoh,matt(2:end,3));
             if lolpos>hohpos 
                 order='Highb4low'; 
             elseif hohpos>lolpos 
                 order='Lowb4high';
             else order='H=L'; end
         end
         
%% (highest+lowest+close)/3 over a future period         
         function hlc3=hlc(instrument,fwdperiod)
            high=instrument.high_price;
            low=instrument.low_price;
            close=instrument.close_price;
            hlc3=nan(length(close),1);
            i=1;
                while i <= (length(close)-fwdperiod)
                    hh=max(high(i+1:i+fwdperiod));
                    ll=min(low(i+1:i+fwdperiod));
                    cc=close(i+fwdperiod);
                    hlc3(i,1)=(hh+ll+cc)/3/close(i)-1;
                    i=i+1;
                end
         end
          
         function [lowest2close,highest2close]=max_ret(instrument,y) %instrument as datafilter; y=y hist bars
            high=instrument.findata2mat(:,3);
            low=instrument.findata2mat(:,2);
            close=instrument.findata2mat(:,4);
            lowest2close=zeros(length(close),1);
            highest2close=zeros(length(close),1);
            for i=y:length(close)
                lowest2close(i)=close(i)/min(low(i+1-y:i))-1;
                highest2close(i)=close(i)/max(high(i+1-y:i))-1;
            end

        end
     end
end

