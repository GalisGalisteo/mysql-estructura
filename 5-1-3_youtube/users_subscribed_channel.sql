-- show users subsribed to a channel, show channel info too

USE `youtube`;

SELECT
	c.channel_id,
    c.name, 
    c.description, 
    c.date_created,
    u.user_id, 
    u.user_name 
FROM channel_subscriptions cs
JOIN users u USING (user_id)
JOIN channels c USING (channel_id)
WHERE channel_id = 2;