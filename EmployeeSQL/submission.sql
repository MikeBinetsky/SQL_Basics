-- Here is my code for the SQL challenge Submission! 

-- First I drop any duplicate tables then I create the new tables and display them.

DROP TABLE IF EXISTS job_titles;

CREATE TABLE job_titles(
	title_id VARCHAR(30) NOT NULL PRIMARY KEY,
	title VARCHAR(30) NOT NULL
);

SELECT * FROM job_titles;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees(
	employee_number INT NOT NULL PRIMARY KEY,
	title_id VARCHAR(30) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex CHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
FOREIGN KEY (title_id) REFERENCES job_titles(title_id)
);

SELECT * FROM employees;

DROP TABLE IF EXISTS departments;

CREATE TABLE departments(
	department_number VARCHAR(30) NOT NULL PRIMARY KEY,
	department_name VARCHAR(30) NOT NULL
);

SELECT * FROM departments;

DROP TABLE IF EXISTS department_employees;

CREATE TABLE department_employees(
	employee_number INT NOT NULL,
	department_number VARCHAR(30) NOT NULL,
	FOREIGN KEY (employee_number) REFERENCES employees(employee_number),
	FOREIGN KEY (department_number) REFERENCES departments(department_number)
);

SELECT * FROM department_employees;

DROP TABLE IF EXISTS department_manager;

CREATE TABLE department_manager(
	department_number VARCHAR(30) NOT NULL,
	employee_number INT NOT NULL,
FOREIGN KEY (employee_number) REFERENCES employees(employee_number),
FOREIGN KEY (department_number) REFERENCES departments(department_number)
);

SELECT * FROM department_manager;

DROP TABLE IF EXISTS employee_salaries;

CREATE TABLE employee_salaries(
	employee_number INT NOT NULL,
	salary INT NOT NULL,
FOREIGN KEY (employee_number) REFERENCES employees(employee_number)
);

SELECT * FROM employee_salaries;

-- This section took a dumb about of time because of my own issues. I kept trying to import the data without refreshing the drops and changes I made \
-- so pgAdmin still thought differently named columns were there when they weren't. Very frustrating but I get it now.

----------------------------------------------------------------------------------------

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
-- I use a join method for this to keep it simple
-- I found that some of the data had repeat key numbers which is why I used the DISTINCT to avoid duplicates.

SELECT DISTINCT e.employee_number, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN employee_salaries s
	ON e.employee_number = s.employee_number
ORDER BY employee_number



-- 2. List first name, last name, and hire date for employees who were hired in 1986
-- This one seems a bit less complex than 1. I use a WHERE to filter by date.

SELECT DISTINCT first_name, last_name, hire_date
FROM employees 
WHERE hire_date >= '1/1/1986' AND hire_date <= '12/31/1986'

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
-- Here we can do two joins at once. Very cool.

SELECT DISTINCT d.department_number, d.department_name, m.employee_number, e.last_name, e.first_name
FROM departments d
JOIN department_manager m
	ON d.department_number = m.department_number
JOIN employees e
	ON e.employee_number = m.employee_number

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
-- This one seems similar to the last one. Double join method should work fine for this as well.

SELECT employee_number, last_name, first_name, department_name
FROM employees e
JOIN department_employees de
	ON e.employee_number = de.employee_number
JOIN 




