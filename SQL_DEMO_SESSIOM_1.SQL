To view Databases;
show databases;

To create Databases;
create database ai_Tamil;

To select the Database
use ai_tamil;

To create table in selected database
create table Employee_user_info (id int not null,Name varchar(25) not null,ph_no long,address varchar(255));

To view the Tables in the database
show tables;

TO View Table values
select * from employee_user_info;

To insert Datas into tables
format 1:
insert into employee_user_info (id,name,ph_no,address) values(1,'karthick',9876543210,'trichy');

format 2:
insert into employee_user_info  values(2,'kowsalya',0123456789,'musiri'),
(3,'santhiya',5678943210,'musiri');

format 3: (can remove not null values and enter other values alone)
insert into employee_user_info (id,address) values(1,'trichy');

To Delete the Table values:
Format 1:
truncate employee_user_info;

Format 2:
delete from employee_user_info;

To Modify Missed Contraint values or to change the data types:
alter table employee_user_info modify column id int not null primary key;

To Add the another Column to the existing table:
alter table employee_user_info add column age int;

To Rename the Column name:
alter table employee_user_info rename column age to age_1;

