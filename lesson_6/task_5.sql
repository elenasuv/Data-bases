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
 
 
