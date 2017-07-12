

for i=1:1000
ac2=paths(:,i,:);

% for i=1:2
%     patha(:,i)=ac2(:,1,i);
% end

pathb=squeeze(ac2);
cor=corrcoef(price2ret(pathb));
val(i)=cor(1,2);
plot(pathb,'DisplayName','patha')
end

K=mean(val);

%%
patha=squeeze(paths(1:100,:,1));
plot(patha);