
use o ;
select * from regions;
select * from countries;
select * from locations;
select * from departments;
select * from employees;
select * from job_history;
select * from jobs;

#page : 1
/*1. Display all information in the tables EMP and DEPT.*/
select * from employees;
select * from departments;


/*2. Display only the hire date and employee name for each employee.*/
select first_name,hire_date from employees;

/*3. Display the ename concatenated with the job ID, separated by a comma and space, and 
name the column Employee and Title*/
select concat(first_name, ", ",job_id)as `Employee and Title` from employees;

/*4. Display the hire date, name and department number for all clerks.*/
select first_name,hire_date,department_id,job_id from employees where job_id like "%clerk";

/*5. Create a query to display all the data from the EMP table. Separate each column by a 
comma. Name the column THE OUTPUT*/
select concat(employee_id, ', ',first_name, ', ',last_name, ', ',email, ', ',phone_number, ', ',hire_date, ', ',job_id, ', ',salary, ', ',commission_pct, ', ',manager_id, ', ',department_id)as `THE OUTPUT` from employees;

/*6. Display the names and salaries of all employees with a salary greater than 2000.*/
select first_name,salary from employees where salary>2000;

/*7. Display the names and dates of employees with the column headers "Name" and "Start 
Date" */
select first_name as `Name`,hire_date as `Start Date` from employees;

/*8. Display the names and hire dates of all employees in the order they were hired.*/
select first_name,hire_date from employees order by hire_date;

/*9. Display the names and salaries of all employees in reverse salary order.*/
select first_name,salary from employees order by salary desc;

/*10. Display 'name" and "deptno" who are all earned commission and display salary in 
reverse order. */
select first_name,department_id,salary from employees where commission_pct is not null order by salary desc;

/*11. Display the last name and job title of all employees who do not have a manager*/
select last_name,job_id from employees where manager_id is null;

/*12. Display the last name, job, and salary for all employees whose job is sales representative 
or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000*/
select last_name,job_id,salary from employees where job_id in("sa_rep","st_clerk") and salary not in(2500,3500,5000);


#page : 2
use o ;

/*1) Display the maximum, minimum and average salary and commission earned.*/
 select max(salary),min(salary),avg(salary),max(commission_pct),min(commission_pct),avg(commission_pct) from employees; 
 
/*2) Display the department number, total salary payout and total commission payout for 
each department.*/
select department_id,sum(salary),sum(commission_pct) from employees group by department_id;

/*3) Display the department number and number of employees in each department. */
select department_id,count(department_id) from employees group by department_id;

/*4) Display the department number and total salary of employees in each department. */
select department_id,sum(salary) from employees group by department_id; 

/*5) Display the employee's name who doesn't earn a commission. Order the result set 
without using the column name*/
select first_name from employees where commission_pct is null;

/*6) Display the employees name, department id and commission. If an Employee doesn't 
earn the commission, then display as 'No commission'. Name the columns appropriately
*/
select first_name,department_id,(case when commission_pct is not null then commission_pct * 1 else 'no commission' end) as total_commission from employees;

/*7) Display the employee's name, salary and commission multiplied by 2. If an Employee 
doesn't earn the commission, then display as 'No commission. Name the columns 
appropriately*/
SELECT first_name, salary,(CASE WHEN commission_pct > 0 THEN commission_pct * 2 ELSE 'No Commission'END) as total_commission FROM employees;

/*8) Display the employee's name, department id who have the first name same as another 
employee in the same department*/
select first_name,department_id from employees where(first_name,department_id) in (select first_name,department_id from employees group by first_name,department_id having count(*)>1);

/*9) Display the sum of salaries of the employees working under each Manager. */
select manager_id,sum(salary) as total_salary from employees group by manager_id;

/*10) Select the Managers name, the count of employees working under and the department 
ID of the manager. */
 select M.employee_id AS manager_id,M.first_name AS manager_name, M.department_id AS manager_department,COUNT(E.employee_id) AS employees_count from employees M left join  employees E ON M.employee_id = E.manager_id group by M.employee_id, M.first_name, M.department_id;

/*11) Select the employee name, department id, and the salary. Group the result with the 
manager name and the employee last name should have second letter 'a! */
 SELECT e.last_name, e.department_id, e.salary, CONCAT(m.first_name, ' ', m.last_name) AS manager_name from employees e JOIN employees m ON e.manager_id = m.employee_id where e.last_name like '_a%' GROUP BY manager_name, e.last_name, e.department_id, e.salary;

 /*12) Display the average of sum of the salaries and group the result with the department id. 
Order the result with the department id.*/
select department_id,avg(total_salary) as average_salary from (select department_id,sum(salary) as total_salary from employees group by department_id) as department_salary group by department_id order by department_id;

/*13) Select the maximum salary of each department along with the department id */
select max(salary),e.department_id,d.department_name from employees e inner join departments d on e.department_id = d.department_id group by department_id;

/*14) Display the commission, if not null display 10% of salary, if null display a default value 1*/
 select commission_pct, case when commission_pct is not null then salary * 0.1 else 1 end as calculated_commission from employees;
 #page:3
  /*1. Write a query that displays the employee's last names only from the string's 2-5th 
position with the first letter capitalized and all other letters lowercase, Give each column an 
appropriate label.*/
select substring(last_name,1,5) as extractstring from employees;

/*2. Write a query that displays the employee's first name and last name along with a " in 
between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the 
month on which the employee has joined.*/   
select concat(first_name, '"a"', last_name) AS full_name,MONTH(hire_date) AS join_month from employees;

/*3. Write a query to display the employee's last name and if half of the salary is greater than 
ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 
1500 each. Provide each column an appropriate label.*/
select last_name,case when salary * 0.5 > 10000 then round(salary * 1.1 + 1500,2) else round(salary * 1.115 + 1500,2) end as increased_salary from employees;

/*4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, 
department id, salary and the manager name all in Upper case, if the Manager name 
consists of 'z' replace it with '$!*/
select  CONCAT(SUBSTRING(Employee_id, 1, 2), '00E') AS ModifiedEmployeeID,Department_id AS ModifiedDepartmentID,UPPER(Salary) AS ModifiedSalary,REPLACE(UPPER(Manager_id), 'Z', '$!') AS ModifiedManagerName from employees; 

/*5. Write a query that displays the employee's last names with the first letter capitalized and 
all other letters lowercase, and the length of the names, for all employees whose name 
starts with J, A, or M. Give each column an appropriate label. Sort the results by the 
employees' last names*/
 select CONCAT(UPPER(SUBSTRING(last_name, 1, 1)), LOWER(SUBSTRING(last_name, 2))) AS "Capitalized Last Name",  LENGTH(last_name) AS "Name Length" from employees WHERE last_name LIKE 'J%' OR last_name LIKE 'A%' OR last_name LIKE 'M%' order by last_name;

/*6. Create a query to display the last name and salary for all employees. Format the salary to 
be 15 characters long, left-padded with $. Label the column SALARY*/
select last_name,lpad(salary,15,'$') salary from employees;

/*7. Display the employee's name if it is a palindrome*/
select first_name from employees where upper(first_name) = upper(reverse (first_name));

/*8. Display First names of all employees with initcaps.*/
SELECT CONCAT(UPPER(SUBSTRING(First_Name, 1, 1)), LOWER(SUBSTRING(First_Name, 2))) AS FormattedFirstName from employees;

/*9. From LOCATIONS table, extract the word between first and second space from the 
STREET ADDRESS column. */
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(STREET_ADDRESS, ' ', 3), ' ', -1) AS WordBetweenSpaces from locations;

/*10. Extract first letter from First Name column and append it with the Last Name. Also add 
"@systechusa.com" at the end. Name the column as e-mail address. All characters should 
be in lower case. Display this along with their First Name.*/
 select first_name,LOWER(CONCAT(SUBSTRING(First_Name, 1, 1), Last_Name,'@systechusa.com')) AS Email_address from employees;

/*11. Display the names and job titles of all employees with the same job as Trenna. */
select first_name,job_id from employees where job_id = (select job_id from employees where first_name = "trenna");
 
 /*12. Display the names and department name of all employees working in the same city as
Trenna.*/
select first_name , department_id from employees where department_id = (select department_id from employees where firST_name ="trenna");
/*13. Display the name of the employee whose salary is the lowest.*/
select first_name,salary from employees where salary in(select min(salary) from employees);

/*14. Display the names of all employees except the lowest paid.*/
select first_name , salary from employees where salary not in(select min(salary) from employees);

#page : 4

/*1. Write a query to display the last name, department number, department name for all
employees.*/
select e.last_name,e.department_id,d.department_name from employees e join departments d on e.department_id = d.department_id;

/*2. Create a unique list of all jobs that are in department 4. Include the location of the
department in the output.*/
select e.job_id,d.location_id from employees e join departments d on e.department_id = d.department_id where e.department_id = 4;

/*3. Write a query to display the employee last name,department name,location id and city of
all employees who earn commission.*/
select e.last_name,d.department_name,d.location_id,l.city from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id where e.commission_pct is not null;

/*4. Display the employee last name and department name of all employees who have an 'a'
in their last name*/
select e.last_name,d.department_name from employees e join departments d on e.manager_id = d.manager_id where last_name like '%a%';

/*5. Write a query to display the last name,job,department number and department name for
all employees who work in LONDON.*/
select e.last_name,e.job_id,e.department_id,d.department_name from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id where l.city = 'london';

/*6. Display the employee last name and employee number along with their manager's last
name and manager number*/
SELECT w.last_name "Employee", w.employee_id "EMP", m.last_name "Manager", m.employee_id "Mgr" FROM employees w join employees m ON (w.manager_id = m.employee_id);

/*7. Display the employee last name and employee number along with their manager's last
name and manager number (including the employees who have no manager).*/
SELECT e1.last_name AS "Employee Last Name", e1.employee_id AS "Employee Number",COALESCE(e2.last_name, 'No Manager') AS "Manager Last Name", COALESCE(e2.employee_id, 'N/A') AS "Manager Number"FROM employees e1 LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;

/*8. Create a query that displays employees last name,department number,and all the
employees who work in the same department as a given employee.*/
select e.last_name,d.department_id from employees e join departments d on e.department_id = d.department_id order by e.last_name,d.department_id;
/*9. Create a query that displays the name,job,department name,salary,grade for all
employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C)*/
select e.first_name,e.job_id,d.department_name,e.salary,case WHEN e.salary >= 50000 THEN 'A' WHEN e.salary >= 30000 THEN 'B'else 'c' end as grade from employees e join departments d on e.department_id = d.department_id;

/*10. Display the names and hire date for all employees who were hired before their
managers along withe their manager names and hire date. Label the columns as Employee
name, emp_hire_date,manager name,man_hire_date*/
select e1.first_name AS "Employee name",e1.hire_date AS "emp_hire_date", e2.first_name AS "Manager name",e2.hire_date AS "man_hire_date" from employees e1 join employees e2 ON e1.manager_id = e2.employee_id where e1.hire_date < e2.hire_date;

# page:5
/*1. Write a query to display employee numbers and employee name (first name, last name) 
of all the sales employees who received an amount of 2000 in bonus.*/
/* bonuse cloum not exist in employees table*/
use
 adventureworks ;
/*2. Fetch address details of employees belonging to the state CA. If address is null, provide
default value N/A.*/
select addressline1,city from address where city = "calgary";

/*3. Write a query that displays all the products along with the Sales OrderID even if an order
has never been placed for that product.*/
SELECT p.Name AS ProductName, s.SalesOrderID FROM Product p LEFT JOIN SalesOrderDetail s ON p.ProductID = s.ProductID ORDER BY p.ProductID;

/*5. Display the employee id and employee name of employees who do not have manager.*/
SELECT EmployeeID FROM Employee WHERE ManagerID IS NULL;

/*6. Find the products that have more than one vendor.*/
SELECT P.ProductID,P.Name AS ProductName,COUNT(DISTINCT PV.VendorID) AS VendorCount FROM Product P JOIN ProductVendor PV ON P.ProductID = PV.ProductID GROUP BY P.ProductID, P.Name HAVING COUNT(DISTINCT PV.VendorID) > 1;

/*7. Find all the customers who do not belong to any store.*/
SELECT C.CustomerID FROM Customer AS C left JOIN Store AS SC ON C.CustomerID = SC.CustomerID WHERE SC.CustomerID IS NULL;
/*8. Find sales prices of product 718 that are less than the list price recommended for that
product.*/
SELECT P.ProductID, P.Name AS ProductName, D.SalesOrderID, D.UnitPrice, p.ListPrice FROM Product P JOIN SalesOrderDetail D ON P.ProductID = D.ProductID WHERE P.ProductID = 718 AND D.UnitPrice < p.ListPrice;

/*9. Display product number, description and sales of each product in the year 2001.*/
SELECT p.ProductNumber,p.Name AS ProductDescription,SUM(sod.OrderQty * sod.UnitPrice) AS TotalSales FROM SalesOrderHeader soh JOIN SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID JOIN Product p ON sod.ProductID = p.ProductID WHERE YEAR(soh.OrderDate) = 2001 GROUP BY p.ProductNumber, p.Name;

/*10. Build the logic on the above question to extract sales for each category by year. Fetch
Product Name, Sales_2001, Sales_2002, Sales_2003.*/
SELECT P.Name AS ProductName,
    SUM(CASE WHEN YEAR(H.OrderDate) = 2001 THEN D.LineTotal ELSE 0 END) AS Sales_2001,
    SUM(CASE WHEN YEAR(H.OrderDate) = 2002 THEN D.LineTotal ELSE 0 END) AS Sales_2002,
    SUM(CASE WHEN YEAR(H.OrderDate) = 2003 THEN D.LineTotal ELSE 0 END) AS Sales_2003
FROM SalesOrderHeader H JOIN SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID JOIN Product P ON D.ProductID = P.ProductID GROUP BY P.Name ORDER BY P.Name;

#page : 6
use o ;
/*1. Write a query to display the last name and hire date of any employee in the same
department as SALES.*/
select e.last_name,e.hire_date from employees e join departments d on e.department_id = d.department_id where department_name = "sales";

/*2. Create a query to display the employee numbers and last names of all employees who
earn more than the average salary. Sort the results in ascending order of salary.*/
select employee_id,last_name,salary from employees where salary > (select avg(salary) from employees) order by salary asc;

/*3. Write a query that displays the employee numbers and last names of all employees who
work in a department with any employee whose last name contains a' u*/
select e.employee_id,e.last_name,d.department_name from employees e join departments d on e.department_id = d.department_id where e.last_name like '%u%';

/*4. Display the last name, department number, and job ID of all employees whose
department location is LONDON.*/
select e.last_name,e.job_id,d.department_id from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id where l.city = 'london';

/*6. Display the department number, last name, and job ID for every employee in the
OPERATIONS department.*/
select d.department_id,e.last_name,e.job_id from employees e join departments d on e.department_id = d.department_id where d.department_name ='operations';

/*7. Modify the above query to display the employee numbers, last names, and salaries of all
employees who earn more than the average salary and who work in a department with any
employee with a 'u'in their name.*/
select employee_id,last_name,salary from employees where salary > (select avg(salary) from employees) and department_id in (select distinct department_id from employees where last_name like '%u%');
 
 /*8. Display the names of all employees whose job title is the same as anyone in the sales
dept.*/
select e.first_name from employees e join departments d on e.department_id = d.department_id where department_name = 'sales';

/*9. 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last
names and salaries.*/
select last_name,salary from employees order by salary desc limit 3;

/*11. Display the names of all employees with their salary and commission earned. Employees
with a null commission should have O in the commission column*/
SELECT first_name,salary,COALESCE(commission_pct, 0) AS commission_earned FROM employees;

/*12. Display the Managers (name) with top three salaries along with their salaries and
department information.*/
select CONCAT(e.first_name, ' ', e.last_name) AS manager_name,e.salary,d.department_name from employees e join departments d on e.department_id = d.department_id join jobs j on e.job_id = j.job_id where j.job_title like '%manager%' order by e.salary desc limit 3;

#page : 7

/*1) Find the date difference between the hire date and resignation_date for all the
employees. Display in no. of days, months and year(1 year 3 months 5 days).
Emp_ID Hire Date Resignation_Date*/
SELECT employee_id,start_Date,end_Date,CONCAT(FLOOR(DATEDIFF(end_Date, start_Date) / 365), ' years ',FLOOR((DATEDIFF(end_Date, start_Date) % 365) / 30), ' months ',(DATEDIFF(end_Date, start_Date) % 365) % 30, ' days'  ) AS Duration FROM job_history;
 

/*3) Calcuate experience of the employee till date in Years and months(example 1 year and 3
months)*/
SELECT employee_id,start_date,end_date,CONCAT(FLOOR(TIMESTAMPDIFF(MONTH, start_date, COALESCE(end_date, CURRENT_DATE())) / 12), ' years ',TIMESTAMPDIFF(MONTH, end_date, COALESCE(end_date, CURRENT_DATE())) % 12, ' months') AS experience FROM job_history;


/*6. Find the products that have more than one vendor.*/
SELECT P.ProductID,P.Name AS ProductName,COUNT(DISTINCT PV.VendorID) AS VendorCount FROM Product P JOIN ProductVendor PV ON P.ProductID = PV.ProductID GROUP BY P.ProductID, P.Name HAVING COUNT(DISTINCT PV.VendorID) > 1;

/*8. Find sales prices of product 718 that are less than the list price recommended for that
product.*/
SELECT P.ProductID, P.Name AS ProductName, D.SalesOrderID, D.UnitPrice, p.ListPrice FROM Product P JOIN SalesOrderDetail D ON P.ProductID = D.ProductID WHERE P.ProductID = 718 AND D.UnitPrice < p.ListPrice;

/*9. Display product number, description and sales of each product in the year 2001.*/
SELECT p.ProductNumber,p.Name AS ProductDescription,SUM(sod.OrderQty * sod.UnitPrice) AS TotalSales FROM SalesOrderHeader soh JOIN SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID JOIN Product p ON sod.ProductID = p.ProductID WHERE YEAR(soh.OrderDate) = 2001 GROUP BY p.ProductNumber, p.Name;

/*10. Build the logic on the above question to extract sales for each category by year. Fetch
Product Name, Sales_2001, Sales_2002, Sales_2003.*/
SELECT P.Name AS ProductName,
    SUM(CASE WHEN YEAR(H.OrderDate) = 2001 THEN D.LineTotal ELSE 0 END) AS Sales_2001,
    SUM(CASE WHEN YEAR(H.OrderDate) = 2002 THEN D.LineTotal ELSE 0 END) AS Sales_2002,
    SUM(CASE WHEN YEAR(H.OrderDate) = 2003 THEN D.LineTotal ELSE 0 END) AS Sales_2003
FROM SalesOrderHeader H JOIN SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID JOIN Product P ON D.ProductID = P.ProductID GROUP BY P.Name ORDER BY P.Name;




SELECT Employee_ID, start_Date,  
CONCAT(FLOOR(DATEDIFF( " ",start_Date) / 365), ' years ', 
FLOOR(MOD(DATEDIFF( "",start_Date), 365) / 30), ' months ', 
MOD(MOD(DATEDIFF( "",start_Date), 365), 30), ' days') AS Date_Difference
FROM Employees
WHERE start_date IS  NOT NULL;




