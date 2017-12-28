%% Example Title
% Summary of example objective
% x = -1:0.1:8;
% y = schaffer2(x);
% 
% plot(x,y(:,1),'.r'); hold on
% plot(x,y(:,2),'.b');
lb = -1.5;
ub = 0;
numberOfVariables=2;
FitnessFunction = @(x) vec_multiobjective(x);
options = gaoptimset('Vectorized','on');
gamultiobj(FitnessFunction,numberOfVariables,[],[],[],[],lb,ub,options);