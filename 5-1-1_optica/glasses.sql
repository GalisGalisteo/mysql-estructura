USE `cul-d-ampolla`;

SELECT
	g.glasses_id,
    g.brand_id,
    b.name AS brand_name,
    g.frame_type,
    g.frame_color,
    g.lens_gradation,
    g.price,
	g.supplier_id,
	s.name AS supplier_name
FROM glasses g
	JOIN brand b USING (brand_id)
	JOIN suppliers s
		ON g.supplier_id = s.supplier_id;