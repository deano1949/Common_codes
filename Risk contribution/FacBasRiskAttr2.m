%% Introduction
% This file tests the model for Factor-Based Risk Attribution
% Reference: Finvex white paper on asset allocation with risk factors

%% Data loads
function [x,RCEstimate,VolERC,RC,gamma,beta]=FacBasRiskAttr2(Y,OI,w,x0)
%Input: Y   dependent variable
%       OI  independent variables
%       w   
[yr,yc]=size(Y);
if yc==1
    Y=[Y zeros(yr,1)];
    w=[w;0];
end
type='lasso';
% type='multi';
[gamma,RC,MR,var,beta]=riskcontri_factor(Y,OI,w,type);

S=cov(OI);
sz=size(OI,2);
RC=RC(1:sz);

%% Optimisation
Aeuq=ones(1,sz); %ensure sum of weights is 100%
Beuq=1;
if nargin<=3
    x0=1/sz.*ones(sz,1);
else
    if x0~=(1/sz*ones(sz,1))
        ub=x0+0.01;
        lb=max(0,x0-0.01);
    else
        ub=ones(sz,1);
        lb=zeros(sz,1);
    end
end 

opts= optimset('Display','off','TolFun',1e-30,'TolX',1e-6);

x=fmincon(@(x)riskcon(x,S,RC.*var),x0,[],[],Aeuq,Beuq,lb,ub,[],opts);
RCEstimate = x.*(S*x)/(x'*S*x);
VolERC = sqrt(x'*S*x);
end
%%
function f=riskcon2(x,sigma,riskcontri)
    sz=size(x,1);
    S=sigma*x;
    f=0;
    f=f+100000000*((x(1)*S(1)-riskcontri(1))^2+(x(2)*S(2)-riskcontri(2))^2);
    for i=3:sz
        f=f+10000*(x(i)*S(i)-riskcontri(i))^2;
    end
    f=f/(x'*S);
end

function f=riskcon(x,sigma,riskcontri)
    sz=size(x,1);
    S=sigma*x;
    f=0;
    for i=1:sz
        f=f+10000*(x(i)*S(i)-riskcontri(i))^2;
    end
    f=f/(x'*S);
end