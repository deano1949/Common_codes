function y = schaffer2(x)
%SCHAFFER2 Summary of this function goes here
%   Detailed explanation goes here
% Initialize y for two objectives and for all x
y = zeros(length(x),2); % ready for vectorization

% Evaluate first objective. 
% This objective is piecewise continuous.
for i = 1:length(x)
    if x(i) <= 1
        y(i,1) = -x(i);
    elseif x(i) <=3 
        y(i,1) = x(i) -2; 
    elseif x(i) <=4 
        y(i,1) = 4 - x(i);
    else 
        y(i,1) = x(i) - 4;
    end
end

% Evaluate second objective
y(:,2) = (x -5).^2;

end

