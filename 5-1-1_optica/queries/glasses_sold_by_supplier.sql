-- glasses sold list by supplier and subtotal

USE `cul-d-ampolla`;

SELECT 
	s.supplier_id,
    s.name,
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
JOIN order_glasses og USING (order_id)
JOIN glasses g USING (glasses_id)
JOIN suppliers s USING (supplier_id)
JOIN brand b USING (brand_id)
ORDER BY supplier_id;