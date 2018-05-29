function info= bbggetstaticdata(name,field)
%BBGGETSTATICDATA Get Bloomberg  static data
% javaaddpath('F:\MATLAB\blpapi3.jar');
c=blp;

info=getdata(c,name,field);
close(c);
end

