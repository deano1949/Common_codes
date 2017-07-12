function [x,fval,exitflag,output,population,score] = moopttest(nvars,lb,ub)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = gaoptimset;
%% Modify options setting
options = gaoptimset(options,'Display', 'on');
options = gaoptimset(options,'PlotFcns', { @gaplotpareto });
[x,fval,exitflag,output,population,score] = ...
gamultiobj(@mymultil,nvars,[],[],[],[],lb,ub,[],options);
