function Xcorrel= movingCrossCorrel(X,t)
%MOVINGCROSSCORREL calculates moving cross correlations between input asset
%returns
%----------------------------------------
%INPUT: X:  matrix of asset returns
%       t:  time windows
%OUTPUT:Xcorrel: moving cross correlation (inter-asset correlation)

Xcorrel=NaN(size(X,1),1);

for i=t:size(X,1)
    dat=X(i-t+1:i,:);
    correl=corrcoef(dat); correl(isnan(correl))=0;
    Xcorrel(i)=(sum(sum(correl))-size(dat,2))/(size(dat,2)^2-size(dat,2));
end


end

