function beta2inx= movingBeta(y,x,t)
%MOVINGBETA calculates the moving beta to an index
%INPUT: y:  vector of asset returns
%       x: returns of an index
%       t:  time windows
%OUTPUT:beta2Inx: rolling beta to an index

if size(y,2)~=1
    error('Input X must be a vector')
elseif size(x,2)~=1
    error('Input Index must be a vector')
end

beta2inx=movingCorrel2Index(y,x,t).*movingStd(y,t)./movingStd(x,t);


end

