-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT DISTINCT CONCAT(first_name, ' ', last_name) AS user,
 COUNT(*) AS overall_activity
  FROM users
    LEFT JOIN likes
      ON users.id = likes.user_id
    LEFT JOIN media 
      ON users.id = media.user_id
    LEFT JOIN messages
      ON users.id = messages.from_user_id
  GROUP BY users.id
  ORDER BY overall_activity
  LIMIT 10;

