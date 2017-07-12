function mat=Correlated_pricing_generator(mu,sigma,T)
%This file aims to generate random time series which have pre-defined
%correlation matrix.
% Inputs: 
% mu: estimated mean returns
% sigma: estimated/predefined covariance matrix.
% T: number of time periods.
paths_count=1000;
no_assets=size(sigma,2);
mat=zeros(T,paths_count,no_assets);
S0=100*ones(paths_count,no_assets);

for k=1:T
N=randn(no_assets,paths_count); %random time series generated from N are not necessarily uncorrelated
[~,U,~,~]=princomp(N'); %Using PCA to ensure U are totally uncorrelated
C=chol(sigma); %K'*K=C; cholesky matrix
V=C'*U';V=V';
paths=zeros(paths_count,no_assets);
    for i=1:paths_count
        for j=1:no_assets
            paths(i,j)=S0(i,j)*exp((mu(j)-0.5*sigma(j,j))+V(i,j)); %Monte Carlo simulations
        end
    end
    S0=paths;
    mat(k,:,:)=paths;
end

        
        
        