-- sells by the employee Juan Martinez on the year 2022

USE `cul-d-ampolla`;

SELECT
	o.sold_by,
	CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
	o.order_id,
    o.sale_date,
    og.glasses_id,
    b.name,
    g.frame_type,
    g.frame_color,
    g.lens_gradation,
    g.lens_color,
    g.price
FROM orders o
JOIN employees e ON e.employee_id = o.sold_by
JOIN order_glasses og USING (order_id)
JOIN glasses g USING (glasses_id)
JOIN brand b USING (brand_id)
WHERE year(o.sale_date) = 2022 AND employee_id = 1
ORDER BY employee_name;