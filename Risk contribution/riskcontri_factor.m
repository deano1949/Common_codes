function [gamma,riskcontri,marginal_risk,var,B] = riskcontri_factor(Y,factor,weight,type)
%RISKCONTRI_factor : outputs the factor-based risk contribution of underlying securities
%Input:   Y: dependent variable
%         factor: independent variables
%         weight: weights of underlying positions.
%         type: regression type 'leaveout','cv10','multi'
%Output:  gamma: beta + delta 
%         riskcontri: risk contribution of underlying positions.
%         marginal_risk: of underlying positions (not annulaised)
%         var: variance
%         B: Beta (sensitivity)

% type='leaveout';
% type='cv10';
%%
ysz=size(Y,2);
fsz=size(factor,2);
for i=1:ysz
    if strcmp(type,'multi')
        obj=regressgly.linearfit(factor,Y(:,i));
        B(:,i)=double(obj.Coefficients.Estimate);
        res_sigma(i)=std(obj.residuals);
    else
        obj=regressgly.lassofit(factor,Y(:,i),type);
        B(:,i)=obj.coefficient;
        Y_fit=factor*obj.coefficient;
        OP3=regressgly.linearfit(Y_fit,Y(:,1));
        res_sigma(i)=std(OP3.residuals);
    end
        
end
A=transpose(B(1,:));
if strcmp(type,'multi')
    B=transpose(B(2:end,:));
else
    B=B';
end
D=diag(res_sigma);
beta=weight'*B;
delta=weight'*D;
gamma=[beta'; delta'];

S=cov(factor);
theta1=[S zeros(fsz,ysz)]; theta2=[zeros(ysz,fsz) eye(ysz)];
theta=[theta1;theta2];
var=gamma'*theta*gamma;
vol=sqrt(var);

%factor-based risk contribution
sz=size(gamma,1);
riskcontri=zeros(sz,1);
marginal_risk=zeros(sz,1);
for i=1:sz
    sigma=theta*gamma;
    riskcontri(i)=gamma(i)*sigma(i)/var;
    marginal_risk(i)=sigma(i)/vol;
    
end
