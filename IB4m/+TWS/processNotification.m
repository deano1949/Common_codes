function processNotification( n )

    % get the event associated with this notification from handler
    event = n.getSource().getEvent(n.uuid);

    % First forward the event to any TWS Notification listeners
    notify(                               ...
       TWS.Events.getInstance()         , ...
       TWS.Events.NOTIFICATION          , ...
       TWS.EventData.Notification(event)  ...
      );
  
    switch class(event)
        
        case 'com.tws.Handler$MarketDepthEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.MARKETDEPTH               , ...
                TWS.EventData.MarketDepth(event)       ...
            );
        
        case 'com.tws.Handler$MarketDataEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.MARKETDATA                , ...
                TWS.EventData.MarketData(event)        ...
            );
            
        case 'com.tws.Handler$MarketMetadataEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.MARKETMETADATA            , ...
                TWS.EventData.MarketMetadata(event)    ...
            );

        case 'com.tws.Handler$RealTimeBarEvent'

            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.REALTIMEBAR               , ...
                TWS.EventData.RealTimeBar(event)       ...
                  );

        case 'com.tws.Handler$HistoricalDataEvent'

            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.HISTORICALDATA            , ...
                TWS.EventData.HistoricalData(event)    ...
              );

        case 'com.tws.Handler$AccountSummaryEvent'

            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.ACCOUNTSUMMARY            , ...
                TWS.EventData.AccountSummary(event)    ...
              );
          
        case 'com.tws.Handler$AccountUpdateEvent'

            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.ACCOUNTUPDATE             , ...
                TWS.EventData.AccountUpdate(event)     ...
              );

        case 'com.tws.Handler$PositionsEvent'

            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.POSITIONS                 , ...
                TWS.EventData.Positions(event)         ...
            );            
            
        case 'com.tws.Handler$ContractDetailsEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.CONTRACTDETAILS           , ...
                TWS.EventData.ContractDetails(event)   ...
            );
        
        case 'com.tws.Handler$OpenOrderEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.OPENORDER                 , ...
                TWS.EventData.OpenOrder(event)         ...
            );
        
        case 'com.tws.Handler$OrderStatusEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.ORDERSTATUS               , ...
                TWS.EventData.OrderStatus(event)       ...
            );
        
        case 'com.tws.Handler$ExecutionDetailsEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.EXECUTIONDETAILS          , ...
                TWS.EventData.ExecutionDetails(event)  ...
            );
        
        case 'com.tws.Handler$PortfolioUpdateEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.PORTFOLIOUPDATE           , ...
                TWS.EventData.PortfolioUpdate(event)   ...
            );
        
        case 'com.tws.Handler$NextOrderIdEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.NEXTORDERID               , ...
                TWS.EventData.NextOrderId(event)       ...
            );
        
        case 'com.tws.Handler$ScannerDataEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.SCANNERDATA               , ...
                TWS.EventData.ScannerData(event)       ...
            );
        
        case 'com.tws.Handler$OptionComputationEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.OPTIONCOMPUTATION         , ...
                TWS.EventData.OptionComputation(event) ...
            );
        
        case 'com.tws.Handler$ErrorEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.ERROR                     , ...
                TWS.EventData.Error(event)             ...
            );
        
        case 'com.tws.Handler$TimeEvent'
            
            notify(                                    ...
                TWS.Events.getInstance()             , ...
                TWS.Events.TIME                      , ...
                TWS.EventData.Time(event)              ...
            );
        
        otherwise
            warning(['could not process event: ',class(e)])
    end
end