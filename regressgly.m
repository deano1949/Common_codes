classdef regressgly
    %REGRESSGLY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function obj=linearfit(X,y)
            try 
            mdl=LinearModel.fit(X,y,'robust','on');
            info=anova(mdl,'summary');
            obj.summary=anova(mdl,'summary');
            obj.formula=mdl.Formula;
            obj.AdjRsquared=mdl.Rsquared.Adjusted;
            obj.Coefficients=mdl.Coefficients;
            obj.Y_Fitted=mdl.Fitted;
            obj.residuals=mdl.Residuals.Raw;
            obj.fstats=info.F(2);
            catch
            obj.summary=NaN;
            obj.formula=NaN;
            obj.AdjRsquared=NaN;
            obj.Coefficients={NaN NaN;NaN NaN};
            obj.Y_Fitted=NaN;
            obj.residuals=NaN;
            obj.fstats=NaN;
            end
        end
        
        function obj=lassofit(X,y,type)
            if strcmp(type,'leaveout')
                [B FitInfo]=lassoglm(X,y,'normal','CV',size(y,1));
            elseif strcmp(type,'cv10')
                [B FitInfo]=lassoglm(X,y,'normal','CV',10);
            else 
                error('invalid type for lasso model');
            end
            %lassoPlot(B,FitInfo,'plottype','CV')
            obj.coefficient=B(:,FitInfo.IndexMinDeviance);
            obj.lambda=FitInfo.LambdaMinDeviance;
            obj.Intercept=FitInfo.Intercept(FitInfo.IndexMinDeviance);
            obj.MinDev=FitInfo.LambdaMinDeviance;
        end
    end
end

