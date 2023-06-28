USE `cul-d-ampolla`;

SELECT c.client_id, 
c.first_name, 
c.last_name, 
c.address, 
c.city, 
C.zip, 
c.country, 
c.telefon, 
c.email, 
c.registration_date, 
c.recomended_by AS recomended_by_id, 
CONCAT(r.first_name, ' ', r.last_name) AS recommended_by
FROM clients c
LEFT JOIN clients r
	ON c.recomended_by = r.client_id