function [beta,e,Q,R] = KalmanFilterG(x,y,delta,initbeta)
%KALMAN FILTER regression
% Input: 
% x: independent variables
% y: dependent variables
%delta: covariance decay rate;  delta=1 gives fastest change in beta, delta=0.000....1 allows no change (like traditional linear regression).
%initbeta: preset initial beta (a vector)
% Output:
% beta: y=alpha + x* beta
% e: error term (y-y_head)
% Q: variance of error term
x=[ones(size(x)) x];

yhat=NaN(size(y)); % measurement prediction
e=NaN(size(y)); % measurement prediction error
Q=NaN(size(y)); % measurement prediction error variance

% For clarity, we denote R(t|t) by P(t).
% initialize R, P and beta.
R=zeros(2);
P=zeros(2);
beta=NaN(2, size(x, 1));
Vw=delta/(1-delta)*eye(2);
Ve=0.001;

if nargin<4
% Initialize beta(:, 1) to zero
    beta(:, 1)=0;
else
    beta(:,1)=initbeta;
end

% Given initial beta and R (and P)
for t=1:length(y)
    if (t > 1)
        beta(:, t)=beta(:, t-1); % state prediction. Equation 3.7
        R=P+Vw; % state covariance prediction. Equation 3.8
    end
    
    yhat(t)=x(t, :)*beta(:, t); % measurement prediction. Equation 3.9

    Q(t)=x(t, :)*R*x(t, :)'+Ve; % measurement variance prediction. Equation 3.10

    % Observe y(t)
    e(t)=y(t)-yhat(t); % measurement prediction error
    
    K=R*x(t, :)'./Q(t); % Kalman gain
    
    beta(:, t)=beta(:, t)+K*e(t); % State update. Equation 3.11
    P=R-K*x(t, :)*R; % State covariance update. Euqation 3.12

end


