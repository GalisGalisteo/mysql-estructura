USE `vegan_pizzeria`;

SELECT 
    e.employee_id,
    e.job_id,
    e.first_name,
    e.last_name,
    e.nif,
    e.telefon,
    j.description,
    d.delivery_id,
    d.order_id,
    d.delivered_date,
    d.delivered_time,
    COUNT(*) AS delivery_count
FROM 
    employees e
    JOIN job j USING (job_id)
    JOIN delivery d USING (employee_id)
WHERE 
    e.employee_id = 6
GROUP BY 
    e.employee_id,
    e.job_id,
    e.first_name,
    e.last_name,
    e.nif,
    e.telefon,
    j.description,
    d.delivery_id,
    d.order_id,
    d.delivered_date,
    d.delivered_time

UNION ALL

SELECT 
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    SUM(delivery_count) AS total_delivery_count
FROM (
    SELECT 
        COUNT(*) AS delivery_count
    FROM 
        employees e
        JOIN job j USING (job_id)
        JOIN delivery d USING (employee_id)
    WHERE 
        e.employee_id = 6
    GROUP BY 
        e.employee_id,
        e.job_id,
        e.first_name,
        e.last_name,
        e.nif,
        e.telefon,
        j.description,
        d.delivery_id,
        d.order_id,
        d.delivered_date,
        d.delivered_time
) AS subquery;
