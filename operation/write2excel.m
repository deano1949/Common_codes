function FMMain(startdate,enddate,lassoswitch)
% Everything inclusive
% Write Matlab output into Excel

%output=FactorModel('31/05/2010','30/06/2014','on');
output=FactorModel(startdate,enddate,lassoswitch);
outputexcel='Output.xls';
singletab='Singlelinear';
multitab='Multilinear';
lasstab='Lasso';
%Singlelinear
xlswrite(outputexcel,output.secname,singletab,'A3');
xlswrite(outputexcel,output.single,singletab,'B3');
xlswrite(outputexcel,output.singlename,singletab,'E3');

%Multilinear
xlswrite(outputexcel,output.secname,multitab,'A3');
xlswrite(outputexcel,output.factorname,multitab,'D2');
xlswrite(outputexcel,output.multi,multitab,'B3');

%Lasso
xlswrite(outputexcel,output.secname,lasstab,'A3');
xlswrite(outputexcel,output.factorname,lasstab,'D2');
xlswrite(outputexcel,output.lasso,lasstab,'B3');