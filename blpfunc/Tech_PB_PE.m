clc; 
clear all;

c = blp;

%javaaddpath F:\blpapi3.jar

DateVector = {'19921231','19931231','19941231','19951231','19961231','19971231','19981231','19991231','20001231','20011231','20021231','20031231','20041231','20051231','20061231','20071231','20081231','20091231','20101231','20111231','20121231','20131231','20141231','20151231','20161231','20170301'};

PBTechGrowth = zeros(3,size(DateVector,2));
PBTechValue = zeros(3,size(DateVector,2));

%since 1990, P/B of Growth Tech firms (where growth tech firms are top 30% of P/B)
for i = 1:size(DateVector,2)

FirstDate = {'PiTDate' , DateVector(i)};

%This is tech firms with P/B in top 30%
TechGrowthScreenList= eqs(c,'Growth Tech Screen',[],[],[],'overrideFields',FirstDate);
PBTechGrowthSeries = cell2mat(TechGrowthScreenList(2:end,3));

%This is tech firms with P/B in bottom 30%
TechValueScreenList= eqs(c,'Value Tech Screen',[],[],[],'overrideFields',FirstDate);
PBTechValueSeries = cell2mat(TechValueScreenList(2:end,3));

%writes summary stats of P/B after each screen
PBTechGrowth(:,i) = [prctile(PBTechGrowthSeries,75);
                     nanmedian(PBTechGrowthSeries);
                     prctile(PBTechGrowthSeries,25)];

PBTechValue(:,i) = [prctile(PBTechValueSeries,75);
                     nanmedian(PBTechValueSeries);
                     prctile(PBTechValueSeries,25)];
                 
end


%Since 1990, PE ratio of tech group vs PE ratio of SP500
%Since 1990, cash burn rate of tech group
PETech = zeros(3,size(DateVector,2));
PESP500 = zeros(3,size(DateVector,2));
CashBurnTech = zeros(3,size(DateVector,2));

for i = 1:size(DateVector,2)

FirstDate = {'PiTDate' , DateVector(i)};

TechScreenList= eqs(c,'Tech Screen',[],[],[],'overrideFields',FirstDate);
SP500Screen= eqs(c,'SP500 Screen',[],[],[],'overrideFields',FirstDate);

%pulls out PE ratios from tech and SP500 screens
PETechSeries = cell2mat(TechScreenList(2:end,3));
PESP500Series = cell2mat(SP500Screen(2:end,3));

PETech(:,i) = [prctile(PETechSeries,75);
               nanmedian(PETechSeries);
               prctile(PETechSeries,25)];
 
PESP500(:,i) = [prctile(PESP500Series,75);
                nanmedian(PESP500Series);
                prctile(PESP500Series,25)];
 
%pulls out cash burn information from the equity screen            
CashBurnTechSeries = cell2mat(TechScreenList(2:end,4));
CashBurnTech(:,i) = [prctile(CashBurnTechSeries,75);
                nanmedian(CashBurnTechSeries);
                prctile(CashBurnTechSeries,25)];
            
end



close(c)