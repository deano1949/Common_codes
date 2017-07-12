%% Introduction
% This file tests the model for Factor-Based Risk Attribution
% Reference: Finvex white paper on asset allocation with risk factors

%% Data loads
function [wERC,RCERC,VolERC]=EqualRiskAttr(OI)
%Input  OI: matrix of factors or underlying assets (%return)
%Output wERC: optimal weight of equal risk weighted portfolio
%       RCERC: risk contribution
%       VolERC: volatility of equal risk weighted portfolio

Simga=cov(OI);
sz=size(OI,2);

%Optimisation
Aeuq=ones(1,sz); %ensure sum of weights is 100%
Beuq=1;
ub=ones(sz,1);
lb=zeros(sz,1);
w0=1/sz*ones(sz,1);
%w0=rand(sz,1);
opts= optimset( 'Display','off','TolFun',1e-20);

%%Equal Risk Contribution
f=@(w)equalrisk(w,Simga);
wERC=fmincon(f,w0,[],[],Aeuq,Beuq,lb,ub,[],opts);
RCERC = wERC.*(Simga*wERC)/(wERC'*Simga*wERC);
VolERC = sqrt(wERC'*Simga*wERC);
end

function f=equalrisk(x,sigma)
    sz=size(x,1);
    S=sigma*x;
    f=0;i=2;j=1;
    while i<=sz
        while j<sz
            f=f+10000*(x(i)*S(i)-x(j)*S(j))^2;
            j=i;i=i+1;
        end
    end
    f=f/(x'*S);
end

