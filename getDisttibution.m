BOGSOG1=BOGSOG(~isnan(BOGSOG));
BOGSOG1=BOGSOG1(BOGSOG1<0.05);

mu=mean(BOGSOG1);
sigma=std(BOGSOG1);
skew=skewness(BOGSOG1);
kurt=kurtosis(BOGSOG1);

sknew1=pearsrnd(mu,sigma,skew,kurt,2000,1);
sknew2=pearsrnd(mu,sigma,0,kurt,2000,1);
sknew3=pearsrnd(mu,sigma,0,3,length(BOGSOG1),1);

%plot
h1=histogram(BOGSOG1,50);
hold on
h2=histogram(sknew3,50);
% h3=histogram(sknew3,20);
hold off

l = legend('Dist1','Dist2','Dist3');
