-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
    
SELECT (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = from_user_id) AS friend,
  COUNT(DISTINCT messages.id) AS total_messages 
  FROM messages
    JOIN friendship
  ON messages.from_user_id = friendship.user_id 
     OR messages.from_user_id = friendship.friend_id
     AND messages.to_user_id = friendship.user_id 
    JOIN users 
      ON users.id = friendship.user_id
        OR users.id = friendship.friend_id   
  WHERE messages.to_user_id = 65
  GROUP BY messages.from_user_id
  ORDER BY total_messages DESC
  LIMIT 1;
 
DESC messages;
 
 
