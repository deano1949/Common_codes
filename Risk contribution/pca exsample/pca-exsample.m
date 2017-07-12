load BondIndices.mat
matr=fts2mat(BondIndices);
matr=tick2ret(matr);

[r,c]=size(matr);
rollwindows=250*5;
i=1;
k=1;
increment=20;
while i<=r-rollwindows-increment
    dat=matr(i:i+rollwindows,:);
    [pc,score,latent,tsquare] = princomp(dat);
    weight(:,k)=pc(:,1); totweight=sum(pc(:,1));
    wgt=pc(:,1)/totweight;
    k=k+1;
    perf(i:i+increment-1)=matr(i+rollwindows+1:i+rollwindows+increment,:)*wgt;
    i=i+increment;
end
totweight=sum(weight,1);

for j=1:length(weight)
    wgt(:,j)=weight(:,j)/totweight(j);
end
perf=perf';
per=ret2tick(perf);


