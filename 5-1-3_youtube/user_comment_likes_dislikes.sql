-- show list of likes and dislikes an user gave to videos, show video info too

USE `youtube`;

SELECT
	u.user_id,
    u.user_name,
    v.video_id, 
    v.tittle,
    v.description,
    v.size,
    v.file_name, 
    v.duration, 
    v.thumbnail, 
    v.views,
    v.datetime_posted,
    vl.like, 
    vl.like_datetime, 
    vl.dislike, 
    vl.dislike_datetime
  
FROM users u
JOIN video_likes vl USING (user_id)
JOIN videos v USING (video_id)
WHERE u.user_id = 2;