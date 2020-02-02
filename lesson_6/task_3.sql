-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT * FROM likes LIMIT 10;
SELECT * FROM profiles LIMIT 10;
SELECT * FROM target_types;


SELECT COUNT(*)
  FROM likes 
    WHERE target_id IN (  
  SELECT user_id
  FROM profiles
  ORDER BY birthdate DESC)
  AND target_type_id = (SELECT id FROM target_types WHERE name = 'users')
   LIMIT 10;
  
  SET sql_mode = '';


  
