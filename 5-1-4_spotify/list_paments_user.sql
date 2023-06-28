-- list of payments made by an user, show payment info and user name

USE `spotify`;

SELECT 
	u.user_id, 
    u.user_name,
    o.order_id, 
    o.date, 
    o.total, 
    pm.name AS payment_method,
    cc.number,
    cc.expiration_date, 
    cc.security_code
FROM orders o
JOIN subscriptions s USING (subscription_id)
JOIN credit_cards cc USING (credit_card_id)
JOIN payment_methods pm USING (payment_method_id)
JOIN users u USING (user_id)
WHERE s.user_id = 2;