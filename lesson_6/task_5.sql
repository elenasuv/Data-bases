-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
SELECT * FROM likes LIMIT 10;
-- Найдем 10 челоек с наименьшим количеством поставленных ими лайками.
SELECT COUNT(*) AS likes,
  (SELECT CONCAT(first_name, ' ', last_name)
    FROM users
      WHERE users.id = likes.user_id) AS owner
 FROM likes
  GROUP by user_id
  ORDER by likes
  LIMIT 10;
 
 -- Как решил преподаватель. В моем варианте выпадают пользователи, которые не поставили лайки, 
 -- так как я иду по таблице likes
 
 SELECT CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) 
	AS overall_activity 
	FROM users
	ORDER BY overall_activity
	LIMIT 10;
 
 
