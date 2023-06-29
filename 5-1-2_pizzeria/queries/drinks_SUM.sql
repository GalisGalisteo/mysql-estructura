USE `vegan_pizzeria`;

SELECT
    ic.item_category_id,
    ic.name,
    SUM(oi.quantity) AS total_quantity,
    i.name,
    i.description,
    o.location_id
FROM
    order_items oi
    JOIN orders o USING (order_id)
    JOIN items i USING (item_id)
    JOIN item_categories ic USING (item_category_id)
WHERE
    item_category_id = 3 AND location_id = 2
GROUP BY
    ic.item_category_id,
	ic.name,
    i.name,
    i.description,
    o.location_id

UNION ALL

SELECT
    NULL,
    NULL,
    SUM(oi.quantity) AS total_quantity,
    NULL,
    NULL,
    NULL
FROM
    order_items oi
    JOIN orders o USING (order_id)
    JOIN items i USING (item_id)
    JOIN item_categories ic USING (item_category_id)
WHERE
    item_category_id = 3 AND location_id = 2;