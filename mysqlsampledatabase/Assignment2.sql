
-- Create the CompanyDB schema
CREATE DATABASE IF NOT EXISTS CompanyDB;
USE CompanyDB;

-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(100) NOT NULL
);

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    HireDate DATE NOT NULL CHECK (HireDate >= '2000-01-01'),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Projects Table
CREATE TABLE Projects (
    ProjectID INT AUTO_INCREMENT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL UNIQUE,
    StartDate DATE NOT NULL,
    EndDate DATE, CHECK (EndDate > StartDate),
    Budget DECIMAL(15, 2) NOT NULL CHECK (Budget > 0)
);

-- Create Assignments Table
CREATE TABLE Assignments (
    AssignmentID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    ProjectID INT NOT NULL,
    HoursWorked DECIMAL(5, 2) NOT NULL CHECK (HoursWorked >= 0),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- Create Salaries Table
CREATE TABLE Salaries (
    SalaryID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    BaseSalary DECIMAL(10, 2) NOT NULL CHECK (BaseSalary > 0),
    Bonus DECIMAL(10, 2) CHECK (Bonus >= 0),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert into Departments
INSERT INTO Departments (DepartmentName, Location) VALUES
('HR', 'New York'),
('IT', 'San Francisco'),
('Finance', 'Chicago'),
('Marketing', 'Los Angeles');

-- Insert into Employees
INSERT INTO Employees (FirstName, LastName, DepartmentID, DateOfBirth, Email, Gender, HireDate) VALUES
('John', 'Doe', 1, '1985-04-12', 'john.doe@example.com', 'Male', '2010-05-10'),
('Jane', 'Smith', 2, '1990-08-23', 'jane.smith@example.com', 'Female', '2015-07-19'),
('Alice', 'Brown', 3, '1982-11-17', 'alice.brown@example.com', 'Female', '2008-02-25'),
('Bob', 'Johnson', 4, '1979-03-30', 'bob.johnson@example.com', 'Male', '2005-01-15');

-- Insert into Projects
INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget) VALUES
('Website Redesign', '2023-01-01', '2023-12-31', 100000),
('Mobile App Development', '2023-03-01', '2024-02-28', 150000),
('Data Migration', '2022-06-01', '2023-06-30', 50000);

-- Insert into Assignments
INSERT INTO Assignments (EmployeeID, ProjectID, HoursWorked) VALUES
(1, 1, 120),
(2, 2, 250),
(3, 3, 180),
(4, 1, 90);

-- Insert into Salaries
INSERT INTO Salaries (EmployeeID, BaseSalary, Bonus) VALUES
(1, 60000, 5000),
(2, 80000, 7000),
(3, 75000, 6000),
(4, 90000, 10000);

select * from Employees;
select * from departments;
select * from projects;
-- 1 . Retrieve all employees in the IT department

select e.*
from employees e join departments d
on e.departmentid=d.departmentid
where d.departmentName='IT';

-- 2. Find employees hired after 2010
select * from employees where year(HireDate)>2010;

-- 3. List projects with a budget exceeding $80,000
select * from projects where Budget>80000;

-- 4. Sort employees by their hire date in descending order.
select * from Employees
order by hiredate desc;
-- 5. Show projects sorted by their budget in ascending order
select * from projects order by budget asc;
-- 6. Count the number of employees in each department
select d.departmentName ,count(e.employeeid) as Employee_count from employees e join departments d
group by d.departmentName;
-- 7. Display the top 3 employees with the highest base salary
select * from employees e join salaries s 
on e.EmployeeID=s.EmployeeID
order by baseSalary desc
limit 3;
select * from salaries;

-- 8. Retrieve employee names along with their department names
select e.firstname , e. lastname , d.departmentname from employees e  join departments d
on e.departmentId = d.departmentid;

-- 9. List all assignments, including employee and project details.
select * from employees e join assignments a on e.employeeid = a.employeeid 
join projects p on p.projectid = a.projectid ;
-- 10. Find employees working on the project with the highest budget
select e.firstname, e.lastname , p.projectname from employees e join assignments a on e.employeeid = a.employeeid 
join projects p on p.projectid = a.projectid 
where p.budget=( select max(budget) from projects);

-- 11. Calculate the age of each employee.
select firstname, lastname, timestampdiff(year ,dateOfBirth , curdate()) as Age from employees;

-- •	12. Calculate the total salary (base + bonus) for each employee
select  e.firstname , e. lastname , (s.basesalary+s.bonus) as total_salary
from employees e join salaries s on e.employeeid =s.employeeid ;

-- •	Find all employees hired in 2015.
select * from employees 
where year(hiredate)=2015;
-- Retrieve the names of projects ending before December 2023.
select projectname  from projects
where enddate <'2023-12-01';
-- •	List employees with base salaries greater than $70,000.
select e.firstname , e.LastName ,e.email , s.basesalary from employees e join  salaries s
on e.EmployeeID=s.employeeId 
where s.basesalary>70000;

-- Count the number of projects handled by each employee.
select count(*) as Project_count , e.firstname , e.lastname   from employees e join assignments a on e.employeeid = a.employeeid 
join projects p on p.projectid = a.projectid 
group by e.EmployeeID;

-- 	List all departments located in "San Francisco."
select * from departments 
where location="San Francisco";
-- 	Display project names along with total hours worked on each.
select p.projectname, sum(a.hoursworked) as total_works  from projects p join assignments a on p.projectid = a.projectid
group by p.projectid;
-- Find the highest bonus received by any employee.

select e.firstname ,max(s.bonus) as max_bonus 
from employees e  join salaries s
on e.employeeId=s.employeeId
group by e.employeeid;
-- Identify projects that lasted for more than 12 months.

select projectname , startdate , enddate
from projects
where datediff( enddate , startdate)>365;

-- 	Retrieve all projects starting in 2023.
select projectname , startdate 
from projects 
where year(startdate)=2023;

-- 	Calculate the total hours worked by each employee across all projects.
select e.firstname, sum(a.hoursworked) as total_works  from employees e join assignments a on e.employeeid = a.employeeid
group by e.employeeid;
-- Find the department with the most employees.
select d.departmentname , count(e.employeeid) as employee_count
from departments d join employees e
on e.departmentid =d.departmentid
group by e.departmentid
order by employee_count desc
limit 1;
-- List employees who were born before 1985.
select * from  employees
where year(dateofbirth)<1985;