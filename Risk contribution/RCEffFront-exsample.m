%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
% Comparing Equal Risk Contribution and Markovitz Portfolio Optimization using Eurostoxx50 as an example
% Markus Leippold, Fall 2013


% you can choose from a textbook example or you can use real data
% by putting textbookexample equal to 0
textbookexample = 0;

if textbookexample == 0
    %% loading data
    [A B ] =xlsread('euroxx.xlsx') ;                                       % daily prices from EUROSTOXX50 components
    % you may want to use other data...
    %% Reading in the variables and defining basic quantities
    prices  = A(1:end,2:2:end);
    prices(any(isnan(prices),2),:)=[];                                     % remove any row that contains at least one NaN
    dates   = x2mdate(A(1:end,1));
    names   = B(1,2:2:end);
    logret  = diff(log(prices));
    [T N]   = size(logret);
    % mean and covariance
    Sigma   = cov(logret)*252;                                             % I use 252 for annualizing the cov matrix
    Vars    = diag(Sigma);                                                 % variances of the stocks
    mu      = mean(logret)'*252;                                           % mean log returns
    
elseif textbookexample == 1
    mu=[0.07 0.08 0.09 0.10 0.11]';
    sigma=[0.05 0.085 0.09 0.12 0.15]';
    target=0.095;
    N=length(sigma);
    corr=[1	   0.5	 0.2   -0.2	  -0.1  
          0.5  1	 0.25  -0.25  -0.2  
          0.2  0.25	 1	    0.8	   0.5  
         -0.2 -0.25	 0.8	1	   0.6  
         -0.1 -0.2	 0.5	0.6	   1];
    if eig(corr)< 0 | any(abs(corr(:)) > 1) | any(diag(corr) ~= 1 )  %#ok<*OR2>
        display('Not a valid corr matrix')
        return
    end
    Sigma = zeros(N,N);
    for i=1:N
        for j=1:N
            Sigma(i,j)=sigma(i)*corr(i,j)*sigma(j);
        end
    end
    Vars = sigma.^2;
end


% defining auxiliary variables (as in the lecture notes)
e       = ones(size(mu));
a       = mu'/Sigma*mu;
b       = mu'/Sigma*e;
c       = e'/Sigma*e;
d       = a*c - b^2;
k1      = (c*mu - b)./d;
k2      = (a - b*mu)./d;

%% Formulae for the efficient frontier in the (muP,sigmaP)-plane
% No short selling constraint - closed form
nport   = 100;                                                             % number of portfolios to draw the efficient frontier
sigmaP  = (1/c:(max(Vars)-1/c)/nport:max(Vars))'.^(0.5);                   % vector of portfolio variance, 1/c is the MinVar!
muP     = b/c + sqrt(d./c.*(sigmaP.^2 - 1./c));
muP     = real(muP);                                                       % sometimes the MinVaR return causes Matlab to return imaginary number...
Wu      = zeros(N,nport);                                                  % unconstrained weight matrix Wu
for i = 1:length(muP)
    Wu(:,i) = Sigma\(muP(i)*k1 + k2);
end
% Short selling constraint - numerics needed
Aeq     = [mu'; ones(1,N)];
LB      = zeros(1,N);                                                      % one could define other linear constraints
UB      = ones(1,N);                                                       % without much effort...
%opts    = optimset('Algorithm', 'interior-point-convex', 'Display','off');
opts    = optimset( 'Display','off');
b       = min(mu):(max(mu) - min(mu))/nport:max(mu);
Wc      = zeros(N,nport);                                                  % constrained weight matrix Wc
muC     = zeros(1,N);
sigC    = zeros(1,N);
for i = 1:length(b)
    beq             = [b(i); 1];
    [Wc(:,i) varP]  = quadprog(Sigma,[],[],[],Aeq,beq,LB,UB,UB/N,opts);
    muC(i)          = Wc(:,i)'*mu;
    sigC(i)         = sqrt(2*varP);
    RCeff(i,:)      = Wc(:,i).*(Sigma*Wc(:,i))/(Wc(:,i)'*Sigma*Wc(:,i));
end

% selecting the efficient frontier for the constrained case;
muMin   = muC(sigC==min(sigC));
muEff   = muC(muC>=muMin);
sigEff  = sigC(muC>=muMin);
% weights of global Min Var Pf:
wGMinVar = Wc(:,sigC == min(sigC));


%% Equal Risk Contribution


% Sequential Quadratic Programming
f = @(w) func(w,Sigma); 
A = ones(1,N);
b = 1;
lb = zeros(N,1);
w0=1/N*ones(N,1);
 

wERC = fmincon(f,w0,[],[],A,b,lb,[],[],opts);
RCERC = wERC.*(Sigma*wERC)/(wERC'*Sigma*wERC);
muERC = wERC'*mu;
sigERC = sqrt(wERC'*Sigma*wERC);


%% Figure plot
figure(1)
plot(sigERC, muERC ,'r*','MarkerSize', 12)
hold on
plot(sigEff,muEff,'b','Linewidth', 1.5)
plot(sqrt(Vars),mu,'ko')
set(gca, 'Box', 'on', 'Linewidth', 1.5, 'Fontsize', 14)
xlabel('Portfolio standard deviation')
ylabel('Portfolio return')
title('Efficient Frontiers')
legend( 'ERC Portfolio', 'no shorts', 'assets' , 'Location', 'Best')
grid on

figure(2)
area(RCeff)
set(gca, 'Box', 'on', 'Linewidth', 1.5, 'Fontsize', 14)
ylabel('Risk contribution')
xlabel('Portfolio')
title('Risk Contributions')
axis([0 nport 0 1])


figure(3)
subplot(1,2,1)
set(gca, 'Box', 'on', 'Linewidth', 1.5, 'Fontsize', 14)
bar(wERC)
title('ERC portfolio weights')
axis tight
subplot(1,2,2)
set(gca, 'Box', 'on', 'Linewidth', 1.5, 'Fontsize', 14)
bar(wGMinVar)
title('Global minimum var portfolio')
axis tight

