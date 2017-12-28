load examgrades;
test1 = grades(:,2);
x = zscore(test1);
h = kstest(x); %h=0 means accept null, it is normal

%Plot
[f,x_values]=ecdf(x);
F=plot(x_values,f);
set(F,'LineWidth',2);
hold on;
G=plot(x_values,normcdf(x_values,0,1),'r-');
set(G,'LineWidth',2);
legend([F G],...
       'Empirical CDF','Standard Normal CDF',...
       'Location','SE');
%%PDF
x2=0:10;
y2=pdf('Normal',x2,0,1);