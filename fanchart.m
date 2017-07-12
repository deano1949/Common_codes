function h  = fanchart(foredateplot,forecastplot,NumCPV)

          % Take the mean of the forecast matrix to draw the data points
          % NumCPV is the number of quantiles 
          
          % ~~~~~~ Area color map plot for forecast data ~~~~~~~~~~
                  % NumCPV is the number of quantiles      
                  if ~exist('NumCPV','var')
                      NumCPV          =         20 ;
                  end

                  cvalue              =         100/NumCPV;
                  quantiles           =         cvalue:cvalue:100;

                   % Check the inputs for area plot                 
                   % If the observation points are less than the number of the
                   % quantiles, some of the quantiles will share the value of the data                
                   if  size(forecastplot,2)      <       NumCPV
                       warning(message('finance:fanplot:notEnoughDataForQuantiles')); %'The forecast data sample size is less than the quantiles.'
                   end                   
                   
                   h                  =         figure;
                   hold on;
%                    criticaldata       =         critical(1,2);
                   Xarea              =         foredateplot;
                   quanValue          =         ones(1,NumCPV)*forecastplot(2,2);
                   quanValue          =         (quantile(forecastplot',quantiles/100))'; 
                   Yarea              =         quanValue;
                   Yarea(:,2:end)     =         Yarea(:,2:end)-quanValue(:,1:end-1);

                   % Use area function to slice into difference areas
                   harea              =         area(Xarea,Yarea,'basevalue',min(quanValue(:))*1.5);                   
                   set(harea,'LineStyle','none');
                   
                   % Find the color to fill in the areas
                   numColor           =        ceil(NumCPV/2);% how many colors we want
                   fanColor           =        linspace(1,0,numColor)'; % generate 'numColor1' of colors from (0,1)
                   colormapRev        =        flipud(fanColor);
                   fanColor(numColor+1:NumCPV)  =    colormapRev(1:NumCPV-numColor);% match the two sides of the colors to make it mirror effect
                   color              =        [ones(NumCPV,1)*1,fanColor,ones(NumCPV,1)*0];
                   arrayfun(@(h,r,g,b)set(h,'facecolor',[r,g,b]),harea,color(:,1)',color(:,2)',color(:,3)')
                   harea(1).FaceColor =        [1 1 1]; % white                   
                   harea(1).Visible             =    'off';
                   harea(1).ShowBaseLine        =    'off';                  
              
                   
          % ~~~~~~ Line plot for historical data ~~~~~~~~~~~~~~~~~~
%           plot(histdateplot,historicalplot,'LineStyle','--','Marker','o',...
%                                            'MarkerSize',5,'MarkerFaceColor','b',...
%                                            'MarkerEdgeColor','b','LineWidth',1.2,...
%                                            'color','k');
%                                    
          % ~~~~~~ Line plot for forecast data ~~~~~~~~~~~~~~~~~~~~ 
          dateplot                   =         foredateplot;
          foreplot                   =         mean(forecastplot,2); 
          % Take the mean of the forecast matrix to draw the data points          
          plot(dateplot,foreplot,'color','k','LineWidth',2);
          
          ylabel('Y Value');
          title('Financial Forecast Chart');
          grid on;
          box on
          hold off       
            
end            
            
  