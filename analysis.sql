--List the employee number, last name, first name, sex, and salary of each employee (2 points)
SELECT first_name, last_name, employees.emp_no, salary, sex
FROM employees
INNER JOIN salaries
	ON salaries.emp_no = employees.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986 (2 points)
SELECT first_name, last_name, hire_date
	FROM employees
	WHERE hire_date >= '1986-1-1'
	AND hire_date <= '1986-12-31';

--List the manager of each department along with their department number, department name, 
--employee number, last name, and first name (2 points)
SELECT dept_name, last_name, first_name, dept_manager.dept_no, dept_manager.emp_no
	FROM dept_manager
	INNER JOIN departments
	ON departments.dept_no = dept_manager.dept_no
	INNER JOIN employees
	ON employees.emp_no = dept_manager.emp_no;
	
--List the department number for each employee along with that employee’s employee number, 
--last name, first name, and department name (2 points)	
SELECT  employees.emp_no, dept_name, last_name, first_name, dept_emp.dept_no
	FROM employees
	INNER JOIN dept_emp
	ON dept_emp.emp_no = employees.emp_no
	INNER JOIN departments
	ON departments.dept_no = dept_emp.dept_no;


--List first name, last name, and sex of each employee whose first name is Hercules 
--and whose last name begins with the letter B (2 points)
SELECT first_name, last_name, sex
	FROM employees
	WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT first_name, last_name, emp_no
FROM employees
WHERE emp_no in 
(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN
		(
			SELECT dept_no
			FROM departments
			WHERE dept_name = 'Sales'));

--List each employee in the Sales and Development departments, including their employee number, 
--last name, first name, and department name (4 points)
CREATE VIEW sales_dev AS
	SELECT dept_name, dept_no
	FROM departments
	WHERE dept_name  IN ('Sales', 'Development');
SELECT dept_name, sales_dev.dept_no, first_name, last_name, dept_emp.emp_no
FROM sales_dev
INNER JOIN dept_emp
ON dept_emp.dept_no = sales_dev.dept_no
INNER JOIN employees
ON employees.emp_no = dept_emp.emp_no
ORDER BY dept_name DESC;

--List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name) (4 points)
SELECT last_name, COUNT(last_name)
AS no_names
FROM employees
GROUP BY last_name
ORDER BY last_name DESC;
