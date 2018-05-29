pcname=getComputerName;

if strcmp(pcname,'desktop-e09ataq')
    path='C:\Users\GU\Dropbox\GU\1.Investment\4. Alphas (new)\Common_codes\IB4m\';
else
    path='C:\Users\gly19\Dropbox\GU\1.Investment\4. Alphas (new)\Common_codes\IB4m\';
end

javaaddpath(fullfile(path,'Jar','TWS.jar'));

%% Initialize session with Trader Workstation

% initialize session with TWS
session = TWS.Session.getInstance();

% create local buffer for historical data events 
[buf,lh] = TWS.initBufferForEvent(TWS.Events.HISTORICALDATA);

% connect to TWS
session.eClientSocket.eConnect('127.0.0.1',7496,0);
