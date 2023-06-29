-- show related artist from an artist, show also which users follows those related artists

USE `spotify`;

SELECT
a.name AS artist_name,
ar.name AS related_to,
u.user_name AS followed_by
FROM related_artists ra
JOIN artists a ON ra.artist_id = a.artist_id
JOIN artists ar ON ra.related_to_id = ar.artist_id
JOIN artist_followers af ON ra.related_to_id = af.artist_id
JOIN users u USING (user_id)
WHERE ra.artist_id = 1;