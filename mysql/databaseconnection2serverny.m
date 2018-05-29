function conn=databaseconnection2serverny()
javaclasspath('C:\Users\gly19\Dropbox\GU\1.Investment\4. Alphas (new)\Common_codes\mysql\mysql-connector-java-5.1.45\mysql-connector-java-5.1.45-bin.jar');

dbname='input';
username='gly';
password='deano1949';
driver='com.mysql.jdbc.Driver';
dburl=['jdbc:mysql//localhost:13306/' dbname];
hostname='server-ny.thinkinginobjects.com';
% 
%connection part
conn=database(dbname,username,password,'Vendor','MySQL','Server',hostname);
conn=database(dbname,username,password,'Vendor','MySQL','Server',hostname,'PortNumber',13306);

