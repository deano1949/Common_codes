function [mse_sr] = crossvalsharpe(y,k,parition_mode)
%CROSSVALSHARPE: Cross validation optimising sharpe ratio
% by Langyu Gu
%--------------------------------------------------------
%INPUT: 
%y: return time series
%k: k folds
%parition_mode: for cvpartition; 'KFold','HoldOut','LeaveOut')
%---------------------------------------------------------
%OUTPUT:
%mse_sr: variation between train and test sharpe ratios.
%---------------------------------------------------------
cv=cvpartition(numel(y),parition_mode,k);
sr=zeros(k,1); %sharpe ratio
for k=1:k
    trainIdx=cv.training(k);
    testIdx=cv.test(k);
    srTrain=mean(y(trainIdx))*sqrt(252)/std(y(trainIdx));
    srTest=mean(y(testIdx))*sqrt(252)/std(y(testIdx));
    sr(k)=(srTest-srTrain)^2;
end
mse_sr=mean(sqrt(sr));%average of variation between train and test sharpe ratios.

end

