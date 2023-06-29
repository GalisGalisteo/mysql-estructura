-- list of premium users subscribed paying with paypal, show subscription info, paypal user name and user name too

USE `spotify`;

SELECT 
	u.user_id, 
    u.user_name, 
    s.join_date, 
    s.renewal_date,
    pm.name as payment_method,
    p.user_name AS paypal_user
FROM subscriptions s
JOIN payment_methods pm USING (payment_method_id)
JOIN paypal p USING (paypal_id)
JOIN users u USING (user_id)
WHERE payment_method_id = 2;
