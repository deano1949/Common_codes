
time=rsiNothers.timestmap(20:200);
indicator=rsiNothers.WilliamsR(20:200);
price=gbpusd_2013to14.close_price_filtered(20:200);

subplot(2,1,1);
plot(time,indicator);
title('William R');
datetick('x','HH:MM:SS');
subplot(2,1,2);
plot(time,price);
title('Price');
datetick('x','HH:MM:SS');

