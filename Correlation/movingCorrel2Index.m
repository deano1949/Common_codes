function Correl2Inx= movingCorrel2Index(X,Inx,t)
%MOVINGCROSS2Index calculates moving average correlations of input asset
%returns to an index return
%----------------------------------------
%INPUT: X:  matrix of asset returns
%       Inx: returns of an index
%       t:  time windows
%OUTPUT:Correl2Inx: average correlation to an index(inter-asset correlation)

Correl2Inx=NaN(size(X,1),1);

for i=t:size(X,1)
    dat=X(i-t+1:i,:);
    inxdat=Inx(i-t+1:i,:);
    avgcorrel2inx=0;
    for j=1:size(X,2)
        correl2inx=corrcoef(dat(:,j),inxdat);
        correl2inx(isnan(correl2inx))=0;
        avgcorrel2inx=avgcorrel2inx+correl2inx(1,2);
    end
    Correl2Inx(i)=avgcorrel2inx/size(stck,2);
 
end

end

