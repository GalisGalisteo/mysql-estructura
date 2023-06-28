-- show list of likes and dislikes an user gave to comments, show comment info too

USE `youtube`;

SELECT
	u.user_id,
    u.user_name,
    c.comment_id, 
	c.text,
    c.datetime AS datetime_posted,
	cl.like,
    cl.like_datetime, 
    cl.dislike, 
    cl.dislike_datetime
  
FROM users u
JOIN comment_likes cl USING (user_id)
JOIN comments c USING (comment_id)
WHERE u.user_id = 3;