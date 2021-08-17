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

SELECT DISTINCT e.employee_number, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN employee_salaries s
	ON e.employee_number = s.employee_number
ORDER BY employee_number

