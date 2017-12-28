function paths=Correlated_pricing_generator_v0(mu,sigma,T)
%This file aims to generate random time series which have pre-defined
%correlation matrix.
% Inputs: 
% mu: estimated mean returns
% sigma: estimated/predefined covariance matrix.
% T: number of time periods.
paths_count=1000;
no_assets=size(sigma,2);
paths=zeros(paths_count,T,no_assets);
S0=100*ones(no_assets,1);

for k=1:paths_count
    N=randn(T,no_assets); %random time series generated from N are not necessarily uncorrelated
    [~,U,~,~]=princomp(N); %Using PCA to ensure U are totally uncorrelated
    C=chol(sigma); %K'*K=C; cholesky matrix
    V=C*U'; 
    for i=1:T
        for j=1:no_assets
            %paths(k,i,j)=S0(j)*exp((mu(j)-0.5*sigma(j,j))+V(j,i));
            paths(k,i,j)=S0(j)*exp((mu(j)-0.5*sigma(j,j))+V(j,i));
        end
        S0=paths(k,i,:);
        
    end
    S0=100*ones(no_assets,1);
end

        
        
        