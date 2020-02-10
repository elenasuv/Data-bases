-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

DESC messages;

SELECT * FROM messages;
-- Хотела найти все сообщения пользователя с его друзьями и потом по количеству сообщений от конкретного пользователя понять,
--  с кем наш пользователь общался больше всего. К сожалению, не нашла причину ошибки. 

-- Выберем id друзей
SELECT * FROM friendship WHERE user_id = 2 OR friend_id = 2;

-- В один столбец
SELECT friend_id AS id FROM friendship WHERE user_id = 2
UNION
SELECT user_id AS id FROM friendship WHERE friend_id = 2;

-- Выбираем id отправителей сообщений
SELECT from_user_id FROM messages 
  WHERE to_user_id = 2
    AND from_user_id IN (
      SELECT friend_id AS id FROM friendship WHERE user_id = 2
      UNION
      SELECT user_id AS id FROM friendship WHERE friend_id = 2
);

-- Добавляем имя
SELECT (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = from_user_id) AS friend 
  FROM messages 
    WHERE to_user_id = 2
      AND from_user_id IN (
        SELECT friend_id AS id FROM friendship WHERE user_id = to_user_id
        UNION
        SELECT user_id AS id FROM friendship WHERE friend_id = to_user_id    
);

-- Добавляем подсчёт и сортировку
SELECT (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = from_user_id) AS friend,
  COUNT(*) AS total_messages 
  FROM messages 
    WHERE to_user_id = 2 
      AND from_user_id IN (
        SELECT friend_id AS id FROM friendship WHERE user_id = to_user_id
        UNION
        SELECT user_id AS id FROM friendship WHERE friend_id = to_user_id    
        )
    GROUP BY messages.from_user_id
    ORDER BY total_messages DESC
    LIMIT 1;

   
   


      
  


