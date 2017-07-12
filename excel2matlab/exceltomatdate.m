function matdate=exceltomatdate(datecell,format)
% exceltomatdate: convert excel date number in 'cell' into matlab
% datestring in 'cell'

matdate=str2double(datecell); %% str2double convert 'cell' and 'str' into 'double'
matdate=x2mdate(matdate); %% convert excel date number into Matlab date number
matdate=datestr(matdate,format); %% convert datenumber into datestring in 'char'
matdate=cellstr(matdate); %% convert date in 'char' into 'cell'

end