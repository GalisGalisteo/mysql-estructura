-- total orders by client

USE `cul-d-ampolla`;

SELECT 
	o.client_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    o.order_id,
    o.sale_date,
    og.glasses_id,
    b.name,
    g.frame_type,
    g.frame_color,
    g.lens_gradation,
    g.lens_color,
    g.price,
    og.quantity,
    og.quantity * g.price AS subtotal
FROM orders o
JOIN clients c USING (client_id)
JOIN order_glasses og USING (order_id)
JOIN glasses g USING (glasses_id)
JOIN brand b USING (brand_id)
ORDER BY client_id;