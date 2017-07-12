function fulllist=loadfiles(folder, fileformat)
%loadfiles: loads all specified files (.mat,.txt) in a folder
dirlist=dir([folder '/*.' fileformat]);
fulllist=struct;
fulllist.ts=struct;
name1=[];
for d=1:length(dirlist)
    
%     name=strcat('k',num2str(d));
%     [~,~,data]=xlsread(dirlist(d).name);
%     fulllist.(name)=cell2mat(data(13:end,2:end));

    name=dirlist(d).name;
    name2=[folder name];
    [~,~,data]=xlsread(name2);
    data=cell2mat(data(13:end,2:end));
    name0=cell2mat(strreplace({name}));
    k=length(name0)-20;
    name0=name0(1:k);
    fulllist.ts.(name0) = data;
    name1=[name1;cellstr(name0)];
end
fulllist.name=name1;
