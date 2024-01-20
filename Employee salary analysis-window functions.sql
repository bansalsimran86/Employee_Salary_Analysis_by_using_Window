

-------------------- Project: Employee Salary Analysis by using Window Functions ------------------------

--- 1. Database Creation and Data Insertion : Creating a structured database and populating it with relevant employee data.

--Establishing the database.
CREATE database feb_window_function;

--Switching to the created database.
USE feb_window_function;
drop table if exists employees ;
--Creating a table to store employee details.
CREATE TABLE employees (
    emp_no INT PRIMARY KEY identity(1,1),
    department VARCHAR(20),
    salary INT
);

--Adding sample data to the table
INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000),
('engineering', 85000),
('engineering', 72000),
('engineering', 68000),
('engineering', 95000),
('engineering', 80000),
('engineering', 92000),
('engineering', 87000),
('sales', 62000),
('sales', 68000),
('sales', 145000),
('sales', 76000),
('sales', 58000),
('sales', 60000),
('sales', 65000),
('customer service', 42000),
('customer service', 48000),
('customer service', 58000),
('customer service', 42000),
('customer service', 34000),
('customer service', 59000),
('customer service', 56000),
('engineering', 98000),
('engineering', 92000),
('engineering', 87000),
('engineering', 105000),
('engineering', 91000),
('engineering', 98000),
('engineering', 93000),
('sales', 66000),
('sales', 72000),
('sales', 151000),
('sales', 78000),
('sales', 62000),
('sales', 63000),
('sales', 64000),
('customer service', 46000),
('customer service', 52000),
('customer service', 62000),
('customer service', 44000),
('customer service', 36000),
('customer service', 61000),
('customer service', 58000),
('engineering', 91000),
('engineering', 85000),
('engineering', 82000),
('engineering', 99000),
('engineering', 89000),
('engineering', 97000),
('engineering', 94000),
('sales', 70000),
('sales', 76000),
('sales', 157000),
('sales', 80000),
('sales', 67000),
('sales', 68000),
('sales', 69000),
('customer service', 50000),
('customer service', 56000),
('customer service', 66000),
('customer service', 48000),
('customer service', 40000),
('customer service', 65000),
('customer service', 62000),
('engineering', 88000),
('engineering', 83000),
('engineering', 80000),
('engineering', 97000),
('engineering', 87000),
('engineering', 94000),
('engineering', 90000),
('sales', 64000),
('sales', 70000),
('sales', 155000),
('sales', 78000),
('sales', 60000),
('sales', 62000),
('sales', 63000),
('customer service', 44000),
('customer service', 50000),
('customer service', 60000),
('customer service', 42000),
('customer service', 34000),
('customer service', 59000),
('customer service', 56000);

--- 2. Basic Queries and Window Functions Exploration: Fetching basic information and exploring window functions.

--Displaying all employee records.
select * from employees;

--Calculating overall average salary for all employees.
select avg(salary) as avg_dept from employees; 
-------------------------or---------------------------------
select avg(salary) over() as avg_dept from employees; 
-------------------------or---------------------------------
select emp_no,department,salary,
avg(salary) over() as avg_dept from employees;

--Calculating average salary within each department.
select emp_no,department,salary,
avg(salary) over(partition by department) as avg_dept from employees;

--- 3. Creating a View and Analyzing Averages: Creating a view and analyzing average salaries.

--Creating a view with average salaries
create view window_avg as 
        select emp_no,department,salary,
               avg(salary) over(partition by department) as avg_dept 
	    from employees;

--Displaying the view results.
select * from window_avg order by emp_no;

--Calculating average salary for each department.
select department,avg(salary) as avg_dept 
from employees group by department; 

--- 4. Statistical Aggregations and Window Functions: Performing statistical aggregations and exploring advanced window functions.

--Calculating statistical aggregations for all employees.
select emp_no,department,salary, 
       avg(salary) over() as avg_sal,
       min(salary) over() as min_sal,
	   max(salary) over() as max_sal
from employees;

--Calculating statistical aggregations within each department.
select emp_no, department, salary, 
       avg(salary) over(partition by department) as avg_sal ,
       min(salary) over(partition by department) as min_sal  ,
	   max(salary) over(partition by department) as max_sal 
from employees;  

-- 5. Count and Sum Window Functions: Utilizing count and sum window functions.

--Counting employees within each department.
select emp_no, department, salary,
       count(*) over(partition by department) as cnt_of_emp
from employees 
order by emp_no;

--Calculating the total of each department salary and overall total salary.
select emp_no,department,salary,
  sum(salary)over (partition by department) as total_dept_sal,
  sum(salary)over () as total_sal
from employees;

--Comparing the rolling salary of each department with total of each department salary and overall total salary.
select emp_no,department,salary,
  sum(salary)over (partition by department order by salary desc) as t_dept_rolling,
  sum(salary)over (partition by department) as total_dept_sal,
  sum(salary)over () as total_sal
from employees;

-- 6. Advanced Window Functions: Exploring advanced window functions.

--Calculating maximum,minimum and average salary within each department.
select emp_no,department,salary,
  max(salary)over (partition by department) as max_d_s,
  max(salary)over () as max_s,
  min(salary)over (partition by department) as min_d_s,
  min(salary)over () as min_s,
  avg(salary)over (partition by department order by salary) as avg_d_rol,
  avg(salary)over (partition by department) as avg_ept_s,
  avg(salary)over () as avg_s,
  sum(salary)over (partition by department order by salary) as t_d_rol,
  sum(salary)over (partition by department) as t_dept_s,
  sum(salary)over () as t_s
from employees;

--Finding minimum salary in descending order within each department.
select emp_no,department,salary,
  min(salary)over (partition by department order by salary desc) as max_ept_salary
  from employees;

-- 7. Advanced Salary Analysis Queries : Understanding Employee Ranking and Distribution
--Assigning a rank based on overall salary.
select emp_no,department,salary,
  rank() over ( order by salary desc) as overal_salary_rank
  from employees;

--Determining the rank of each employee within their department and the overall ranking based on salary.
select emp_no,department,salary,
  rank() over ( partition by department order by salary desc) as dept_salary_rank,
  rank() over (  order by salary desc) as overal_salary_rank
  from employees;
  
--## if same salary of two cell then rank would be same and next rank will be given after those rank(very typical and important)

--Managing cases where employees have the same salary by assigning the same rank. The next rank is given after those with the same salary.
select emp_no,department,salary,
       rank() over ( partition by department order by salary desc) as dept_salary_rank,
       rank() over (  order by salary desc) as overal_salary_rank
from employees order by department;

--Assigning row numbers, dense ranks, and regular ranks to each employee within their department and overall based on salary.
select emp_no,department,salary,
       row_number() over ( partition by department order by salary desc) as dept_row_no,
       dense_rank() over ( order by salary desc) as dept_salary_dense_rank,
       rank() over ( partition by department order by salary desc) as dept_salary_rank,
       rank() over (  order by salary desc) as overal_salary_rank
from employees order by dept_salary_dense_rank;
  
--Dividing employee salaries into quartiles, providing insights into the distribution and identifying salary ranges.
select emp_no,department,salary, 
       min(salary) over(),
	   max(salary) over(),
       ntile(3)over ( order by salary) as sal_quartile
from employees;
  


