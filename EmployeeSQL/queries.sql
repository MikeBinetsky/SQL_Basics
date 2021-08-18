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

SELECT DISTINCT e.employee_number, e.last_name, e.first_name, d.department_name
FROM employees e
JOIN department_employees de
	ON e.employee_number = de.employee_number
JOIN departments d
	ON d.department_number = de.department_number

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
-- This one is neat. I use another WHERE AND for this one similar to 2.
-- I had to look up the LIKE method using the % in there. Pretty cool! I LIKE it.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT DISTINCT e.employee_number, e.last_name, e.first_name, department_name
FROM employees e
JOIN department_employees de
	ON e.employee_number = de.employee_number
JOIN departments d
	ON de.department_number = d.department_number
WHERE d.department_name = 'Sales'
ORDER BY employee_number

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- This one seems like it'll be tough...NOT! It's the same as the last one except I get to add an OR statement afterwards.

SELECT DISTINCT e.employee_number, e.last_name, e.first_name, department_name
FROM employees e
JOIN department_employees de
	ON e.employee_number = de.employee_number
JOIN departments d
	ON de.department_number = d.department_number
WHERE d.department_name = 'Sales' OR d.department_name = 'Development'
ORDER BY employee_number

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
-- This one took longer than I'd like to admit. Despite reading the errors I missed that I'd need the GROUP BY.

SELECT last_name, COUNT(last_name) AS "count_of_names"
FROM employees
GROUP BY last_name
ORDER BY last_name DESC
