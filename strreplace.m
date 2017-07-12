function oldStr = strreplace(oldStr)

%this function replaces special characters such as $, £, @, : which
%generally are part of datastream tickers into more suitable character so
%that it can be used to save as a header in financial time series object
if(~isempty(cell2mat((strfind(oldStr,'@')))))
    oldStr=strrep(oldStr,'@','at_');
end
if(~isempty(cell2mat((strfind(oldStr,'$')))))
    oldStr=strrep(oldStr,'$','_USD_');
end
if(~isempty(cell2mat((strfind(oldStr,'£')))))
    oldStr=strrep(oldStr,'£','_GBP_');
end
if(~isempty(cell2mat((strfind(oldStr,':')))))
    oldStr=strrep(oldStr,':','_cln_');
end
if(~isempty(cell2mat((strfind(oldStr,'&')))))
    oldStr=strrep(oldStr,'&','_amp_');
end
if(~isempty(cell2mat((strfind(oldStr,' ')))))
    oldStr=strrep(oldStr,' ','_');
end
if(~isempty(cell2mat((strfind(oldStr,'.')))))
    oldStr=strrep(oldStr,'.','_dot_');
end
if(~isempty(cell2mat((strfind(oldStr,'-')))))
    oldStr=strrep(oldStr,'-','_');
end
%     oldStr=strcat('D_',oldStr);
%vectorise this 
    for i =1:length(oldStr)
        if(isstrprop(oldStr{i}(1),'digit'))
            oldStr(i)=strcat('D_',oldStr(i));
        end
    end
    
    
end