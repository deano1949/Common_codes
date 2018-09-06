dbname='testtutorial';
username='root';
password='deano1949';
driver='com.mysql.jdbc.Driver';
dburl=['jdbc:mysql//localhost:3306/' dbname];
javaclasspath('C:\Users\gly19\Dropbox\GU\1.Investment\4. Alphas (new)\Common_codes\mysql\mysql-connector-java-5.1.45\mysql-connector-java-5.1.45-bin.jar');

%connection part
conn=database(dbname,username,password,'Vendor','MySQL','Server','localhost');

% % %data insertion part
% colnames={'idmatrix' 'matrixcol' 'matrixcol1' 'matrixcol2' 'matrixcol3'};
% data=[1 3 4 5 6;
%     2 3 5 6 7
%     3 48 21 34 22];
% datainsert(conn,'matrix',colnames,data);