classdef rsigly2
    %RSIGLY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        period
        timestmap
        RSI
        RSI_zscore
        Kstochastic
        Dstochastic
        SlowDstochastic
        Volatility
        Momentum
        ROC
        WilliamsR
        ADOscillator
        Disparity5
        Disparity10
        OSCP
        CCI
        
    end
    
    methods(Static)
        function obj = rsi(close,period) %RSI
            obj=rsindex(close,period);
        end
        
        function obj=willr(high,low,close,period)%WilliamsR
            obj=willpctr(high,low,close,period);
        end
    end  
    
    methods
            ret=datafilter.ret_filtered;
            high=datafilter.high_price_filtered;
            low=datafilter.low_price_filtered;
            close=datafilter.close_price_filtered;
            hlc3=(high+low+close)/3;
            [row,col]=size(close);


            %WilliamsR
            wpc=willpctr(high,low,close,period);

            %Momentum %ROC (checked)
            lag=period; %variable
            close_lag=[zeros(1,period-1)'; close(1:end-period+1)];
            high_lag=[zeros(1,period-1)'; high(1:end-period+1)];
            low_lag=[zeros(1,period-1)'; low(1:end-period+1)];
            obj.Momentum=close-close_lag;
            obj.ROC=close./close_lag-1;

            %ADOscillator momentum indicator that associates changes in
            %price (checked)
            close1=[0 ; close(1:end-1)];
            obj.ADOscillator=(high-close)./(high-low);

            %Disparity5 and Disparity10 (checked)
            MA5=tsmovavg(close,'s',5,1);
            MA10=tsmovavg(close,'s',10,1);
            obj.Disparity5=close./MA5-1;
            obj.Disparity10=close./MA10-1;
            obj.OSCP=(MA5-MA10)./MA5;

            %CCI commodity channel index (checked)

            lag_CCI=period; %variable
            diff=nan(row,1);
            SM=tsmovavg(hlc3,'s',lag_CCI,1);
            for j=lag_CCI:length(ret)
                diff(j)=mean(abs(hlc3(j-lag_CCI+1:j)-SM(j)));
            end
            obj.CCI=(hlc3-SM)./(0.015*diff);

            for i=period+1:length(ret)
                %Volatility
                vol(i)=std(close(i-period:i)); %(checked)
                %Kstochastic
                highest_high=max(high(i-period:i));
                lowest_low=min(low(i-period:i));
                Kstochastic(i)=(close(i)-lowest_low)/(highest_high-lowest_low)*100;
                Dstochastic(i)=mean(Kstochastic(i-2:i)); %3-days average (so here 2 is variable)
                SlowDstochastic(i)=mean(Dstochastic(i-2:i)); %3-days average (so here 2 is variable)
            end
            nan_seq=nan(period-1,1);

            obj.period=period;
            obj.timestmap=datafilter.time_seq;
            obj.RSI=rsi;
            obj.RSI_zscore=[nan_seq; zscore(rsi(period:end))];
            obj.WilliamsR=wpc;
            obj.Kstochastic=Kstochastic'; %(checked)
            obj.Dstochastic=Dstochastic';
            obj.SlowDstochastic=SlowDstochastic';
            obj.Volatility=vol';
        end
end
    

