%% Execution Details
%
% *DISCLAIMER / WARNING*
%
% Just a heads up, this example will attempt to place an order automatically via the IB API.  
% Please, *use your paper trading account* details when exploring this example.
%
% See Interactive Brokers <https://www.interactivebrokers.com/en/index.php?f=tws&p=papertrader paper trading page> for additional details
%

%% Initialize session with Trader Workstation
%

% initialize session with TWS
session = TWS.Session.getInstance();

% create local buffer for exec details events 
[buf,lh] = TWS.initBufferForEvent(TWS.Events.EXECUTIONDETAILS);

% connect to TWS
session.eClientSocket.eConnect('127.0.0.1',7496,0);

%% Request Order Execution Details

%% 
% In order to get details about orders placed in Trader Workstation,
% it is neccessary to auto-associate TWS order with the API.
% Otherwise, only execution details for order placed from the API will be forwarded.

% associate TWS orders with API
session.eClientSocket.reqAutoOpenOrders(true);

%%
% If there are multiple traders or many many order then will need to filter exec details

% want all the execution entries so init empty filter
filter = com.ib.client.ExecutionFilter();


%%
% Multiple requests for execution details can be active and are differentiated by the reqId.  
% The request ID is just a unique integer identifier.

% create request id for these execution detials.  
reqId = 0;

%% 
% Now, provide request identifier and filter to obtain execution details (default: within last 24 hours)

% request current positions
session.eClientSocket.reqExecutions(0,filter);

%% Order Placement
% To drive this example, an order will be placed via the API

%%
% First create a generic contract for SPY

% create a stock contract for symbol SPY
contract = com.tws.ContractFactory.GenericStockContract('SPY');

%%
% Next, create limit order associated with your account to BUY 100 shares at some price

% create an order with accnt, side, quantity, and price [*USE YOUR IB PAPER TRADING ACCOUNT NUMBER HERE*]
order = com.tws.OrderFactory.GenericLimitOrder('DU207406', 'BUY', 100, 208.17);

%%
% Finally, place the order using *NextOrderId* along with the contract and order details above 

% place the order with contract and order specifications
session.eClientSocket.placeOrder(8855,contract,order);  pause(1);

%% Processing Execution Details Events
% Execution details have a lot of information so make sure to read up on the references listed below.

%%
% It is easy to see how many execution details events are in the buffer by calling the size() method.  
% Keep in mind that the buffer is circular with default size of 32.  
% That is, after buffer capacity is exceeded, adding another event will kickout the oldest event to make room for new event.
buf.size()

%%
% Pull events from the buffer and put into cell array

% create cell array of ExecutionDetails objects
execEvents = collection2cell(buf);

%%
% Print execution details to command window
disp(execEvents{end}.data)

%% See Also
% <matlab:showdemo('TWSNextOrderIdExample') TWSNextOrderIdExample> | <matlab:showdemo('TWSOpenOrdersExample') TWSOpenOrdersExample> | <matlab:showdemo('TWSPositionsExample') TWSPositionsExample>

%% References
% Interactive Brokers API: 
%
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/econnect.htm eConnect>
%
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/reqexecutions.htm EClientSocket:reqExecutions>
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/contractdetails.htm EWrapper:contractDetails>
%
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/order.htm Order>
% * <https://www.interactivebrokers.com/en/software/api/apiguide/tables/supported_order_types.htm SupportedOrderTypes>
%
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/placeorder.htm EClientSocket:placeOrder>
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/cancelorder.htm EClientSocket:cancelOrder>
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/reqglobalcancel.htm EClientSocket:reqGlobalCancel>
%
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/reqids.htm EClientSocket:reqIDs>
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/nextvalidid.htm EWrapper:NextValidId>
%
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/reqautoopenorders.htm EClientSocket:reqAutoOpenOrders>
% 
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/contract.htm com.ib.client.Contract>
%
% TWS@Github:
%
% * <https://github.com/softwarespartan/TWS/blob/master/src/com/tws/ExecutionDetails.java com.tws.ExecutionDetails>
%
% Apache Commons:
%
% * <https://commons.apache.org/proper/commons-collections/javadocs/api-3.2.1/org/apache/commons/collections/buffer/CircularFifoBuffer.html CircularFifoBuffer>