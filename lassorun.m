siz=size(lasso); num_time=siz(1); num_sec=siz(2);num_fac=siz(3);
factname={'C','USD','10Y','2Y',...
    'IG','HY','VIX','World','CS','Engy',...
    'IT','CD','Fin','HC','Indu','Util','Mat',...
    'TelCom','SC','GEM','Oil'};
for j=1:num_sec
    name=Securities.nameid;
    SEC=zeros(num_time,num_fac);
    for k=1:num_fac
        sec=lasso(:,:,k); sec=sec(:,j);
        SEC(:,k)=sec;
    end
    name=name(j);
    name=name{1,1};
    name=name(1:12);
    %SS=dataset(SEC(:,2:end-1),'VarNames',factname);
    eval([name 'lasso.AR2=SEC(:,1);']);
    eval([name 'lasso.Estimates=SEC(:,2:end-1);']);
    eval([name 'lasso.PredictError=SEC(:,end);']);
end
security=US14040H1059lasso;
boxplot(security.Estimates,factname);figure(gcf);grid on;
dataset(security.AR2,'ReadObsNames',datets);
