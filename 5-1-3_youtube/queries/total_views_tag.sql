-- shot total of views on a tag

USE `youtube`;

SELECT 
	t.tag_id, 
    t.tag_name,
    SUM(v.views) AS total_views
FROM videos v
JOIN tags t USING (tag_id)
WHERE tag_id = 5;

