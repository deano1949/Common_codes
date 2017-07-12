classdef returndata 
    
    properties
        currency
        frequency
        dateid
        dateformat
        nameid
        data
        zsdata
        %dataSet
    end
    methods
        function obj=returndata(csvfile,ccy,frequency)
            if isempty(findstr('csv',csvfile))
                error('datafile must be in csv format')
            end
            freq={'D','W','M'};
            if ~ismember(frequency,freq)
                error(message('frequency must be either D,W or M represent Daily,Weekly or Monthly data'));
            end
            
        try
            obj.currency=ccy;
            obj.frequency=frequency;
            fil=csvread(csvfile,1,1);
            col=size(fil);
            col=col(2);
            fileid=fopen(csvfile,'rt');
            date=textscan(fileid, strcat('%s', repmat(' %f',1,col)),'Delimiter',',','HeaderLines',1);
            date=date{1,1};

            %nameid 
            frewind(fileid);
            tline=fgets(fileid);
            nameid=textscan(tline, repmat('%s',1,col+1),'Delimiter',',');
            nameid=nameid(2:end);
            [~,c]=size(nameid);
            for i=1:c
                nameid{i}=nameid{i}{1};
            end
            fclose(fileid);
            
            %dataset
           % obj.dataSet=dataset('file',csvfile,'format',strcat('%s ', repmat('%f ',1,col)) ,'Delimiter',',','ReadObsNames',true);
            obj.dateid=date; %latest end month of the data
            obj.dateformat=date{1};
            obj.nameid=nameid;
            obj.data=fil;
            obj.zsdata=zscore(fil);
        catch
            error('the file must be in the format of Date|Data');
        end
    end
end
%Convert financialdata to timeseries objects
%obj.ts=timeseries(financialdata.data(:,1),financialdata.dateid);
end