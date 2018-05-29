#create a new database
create	schema	`testtutorial2`;

#create a new table
CREATE TABLE `testtutorial2`.`tablename` (
  `idEmployeeName` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NULL,
  `age` INT NULL,
  PRIMARY KEY (`idEmployeeName`));

#insert data into a table
INSERT INTO testtutorial2.tablename (idEmployeeName,name, surname, age) VALUES ('1', 'Mark', 'Gu', '28');
INSERT INTO `testtutorial2`.`tablename` (`idEmployeeName`, `name`, `surname`, `age`) VALUES ('2', 'Paul', 'Lu', '38');
INSERT INTO `testtutorial2`.`tablename` (`idEmployeeName`, `name`, `surname`, `age`) VALUES ('3', 'Simon', 'Mu', '32');
INSERT INTO `testtutorial2`.`tablename` (`idEmployeeName`, `name`, `surname`, `age`) VALUES ('4', 'Rob', 'Hu', '21');
INSERT INTO `testtutorial2`.`tablename` (`idEmployeeName`, `name`, `surname`, `age`) VALUES ('5', 'Peach', 'Lu', '42');

#select and view data
select name,surname,age from testtutorial2.tablename;
select * from testtutorial2.tablename;

#filter data
select * from testtutorial2.tablename where age<35;
select * from testtutorial2.tablename where name='mark' and surname='Gu';
select * from testtutorial2.tablename where name='mark' or age>30;

#sort data
select * from testtutorial2.tablename order by name;
select * from testtutorial2.tablename order by age desc;

#update data
update testtutorial2.tablename set surname='Ma' where idEmployeeName='5';

#delete data
delete from testtutorial2.tablename where idEmployeeName=4;

# sum/average/max/min
select max(age) from testtutorial2.tablename;
select avg(age) from testtutorial2.tablename;
select count(age) from testtutorial2.tablename;
select max(age) from testtutorial2.tablename;
select min(age) from testtutorial2.tablename;

