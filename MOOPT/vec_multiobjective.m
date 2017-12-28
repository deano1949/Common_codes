function scores = vec_multiobjective(pop)
%MULTIOBJECTIVE Summary of this function goes here
%   Detailed explanation goes here
    popSize = size(pop,1); % Population size
     numObj = 2;  % Number of objectives
     % initialize scores
     scores = zeros(popSize, numObj);
     % Compute first objective
     scores(:,1) = (pop + 2).^2 - 10;
     % Compute second obective
     scores(:,2) = (pop - 2).^2 + 20;

end

