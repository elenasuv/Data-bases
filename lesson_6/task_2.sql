-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

DESC messages;

SELECT * FROM messages;
-- Хотела найти все сообщения пользователя с его друзьями и потом по количеству сообщений от конкретного пользователя понять,
--  с кем наш пользователь общался больше всего. К сожалению, не нашла причину ошибки. 

SELECT from_user_id, to_user_id, body, is_delivered, created_at 
  FROM messages
    WHERE (from_user_id = 4
   OR
    from_user_id = (
      SELECT friend_id 
  FROM friendship 
  WHERE user_id = 4
    AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name = 'Confirmed')
)
   (SELECT user_id 
    FROM friendship 
   WHERE friend_id = 4
    AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name = 'Confirmed'
    )
))
     OR (to_user_id = 4
     OR 
     to_user_id = (
      SELECT friend_id 
  FROM friendship 
  WHERE user_id = 4
    AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name = 'Confirmed')
)
UNION
(SELECT user_id 
  FROM friendship 
  WHERE friend_id = 4
    AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name = 'Confirmed'
    )
));
   
   


      
  


