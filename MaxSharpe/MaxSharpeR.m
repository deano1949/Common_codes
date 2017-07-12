function x=MaxSharpeR(dat)
%MaxSharpR: find the portfolio with max sharpe ratio
%Input: dat: data matrix
%Output: x: weights
sz=size(dat,2);

fun=@(x)-mean(dat*x')/std(dat*x');

x0=ones(1,sz)/sz;
A=ones(1,sz);
b=1;
lb=zeros(1,sz);
ub=ones(1,sz);

[x,fval,exitflag,msg]=fmincon(fun,x0,[],[],A,b,lb,ub);

if exitflag==0 %if non-decreasing, then equal weighted
    x=ones(1,size(dat,2))*1/size(dat,2); 
end
