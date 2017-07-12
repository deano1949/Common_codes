function Amyaddpath(location)
%ADDPATH: add all essential paths

if strcmp(location,'Home')
    addpath(genpath('C:\Users\Langyu\Desktop\Dropbox\GU\1.Investment\4. Alphas (new)'));
    addpath(genpath('C:\Users\gly19\Dropbox\GU\1.Investment\4. Alphas (new)\Common_codes'));
    %data
    addpath('C:\Spectrion\Data\AllData\Future_Generic');
elseif strcmp(location,'Coutts')
    addpath(genpath('O:\langyu\Reading\AlgorithmTrading_Chan_(2013)\Custom_Functions'));
    addpath('O:\langyu\Reading\AlgorithmTrading_Chan_(2013)');
else
    error('Unrecognised location; Coutts or Home');
end
end

