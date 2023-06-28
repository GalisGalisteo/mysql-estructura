-- show an user's favorites songs, show song, artist and album info

USE `spotify`;

SELECT 
	u.user_id, 
    u.user_name,
    a.name AS artist_name, 
    al.name AS album_name,
    s.name AS song_name,
    s.duration,
    s.times_played,
    al.year, 
    a.image AS artist_image, 
    al.image AS album_image
FROM user_favorite_songs ufs
JOIN songs s USING (song_id)
JOIN artists a USING (artist_id)
JOIN albums al USING (album_id)
JOIN users u USING (user_id)
WHERE user_id = 1;
