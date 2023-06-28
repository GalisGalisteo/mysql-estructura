USE `vegan_pizzeria`;

SELECT *
FROM employees e
	JOIN job j USING (job_id)
	JOIN delivery d USING (employee_id)
WHERE employee_id = 6;
