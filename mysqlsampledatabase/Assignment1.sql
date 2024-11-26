create database Assignment1;
use Assignment1;
#Write a SQL statement to create a table named countries including columns country_id,
#country_name and region_id and make sure that the country_id column
# will be a key field which will not contain any duplicate data at the time of insertion.
create table Country(countryId int auto_increment primary key,
countryName varchar(50) not null , regionId int not null );

#Write a MySQL statement to create a table job_history including columns
#employee_id, start_date, end_date, job_id and department_id and make sure that, the employee_id
#column does not contain any duplicate value at the time of insertion and the foreign key 
#column job_id contain only those values which are exists in the jobs table.
create table job(jobId varchar(10)  primary key , 
jobTitle varchar(35) not null, minSalary decimal(6,0)  , maxSalary decimal(6,0) );
desc job;
create table JobHistory(
employeeId int auto_increment primary key , 
startDate date , endDate date , jobId varchar(35) , departmentId decimal(4,0)
, foreign key (jobId) references job(jobId));

desc JobHistory;
#Write a SQL statement to create a table employees including columns employee_id, first_name,
#last_name, email, phone_number hire_date, job_id, salary, commission, manager_id and department_id
# and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key columns combined by department_id and manager_id columns contain only those unique combination values,
#which combinations are exists in the departments table.


create table department(departmentId decimal(4,0)   ,
departmentName  varchar(30)  not null ,
managerId decimal(6,0)  ,
locationId decimal(4,0),
primary key(departmentId ,managerId));

create table Employees(
EmployeeId int auto_increment primary key ,
firstName varchar (30) ,
lastName varchar(30),
email varchar(20) not null ,
phone varchar (15) ,
hiredate date,jobId varchar(20) , salary decimal(5,0),
commision decimal(10,0),
managerId decimal(6,0),
departmentId decimal(4,0),
foreign key(departmentId, managerId) references department(departmentId, managerId));