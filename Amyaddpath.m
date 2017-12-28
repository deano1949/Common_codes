function Amyaddpath
%ADDPATH: add all essential paths

%% Get computer name
[ret, name] = system('hostname');   

if ret ~= 0,
   if ispc
      name = getenv('COMPUTERNAME');
   else      
      name = getenv('HOSTNAME');      
   end
end
pcname = strtrim(lower(name));

%% addpath
if strcmp(pcname,'desktop-e09ataq')
    path='C:\Users\GU\Dropbox\GU\1.Investment\4. Alphas (new)\Common_codes';
    addpath(genpath(path));
else
    path='C:\Users\gly19\Dropbox\GU\1.Investment\4. Alphas (new)\Common_codes';
    addpath(genpath(path));
    addpath(genpath('C:\Spectrion\Data\PriceData'));
    addpath(genpath('C:\Spectrion\Data\NewUniverse'));

end


end

