function [riskcontri,marginal_risk] = riskcontri_pos(returndata,weight)
%RISKCONTRI_POS : outputs the position-based risk contribution of underlying securities
%Input:   returndata: underlying return matrix.
%         weight: weights of underlying positions.
%Output:  riskcontri: risk contribution of underlying positions.
%         marginal_risk: of underlying positions (not annulaised)

covar=cov(returndata);
var=weight'*covar*weight;
vol=sqrt(var);
%indu_vol=std(returndata);
sz=size(returndata,2);
riskcontri=zeros(sz,1);
marginal_risk=zeros(sz,1);
for i=1:sz
    sigma=covar*weight;
    riskcontri(i)=weight(i)*sigma(i)/var;
    marginal_risk(i)=sigma(i)/vol;
end
