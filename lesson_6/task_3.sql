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
 
-- Как решил преподаватель

-- Смотрим типы для лайков
SELECT * FROM target_types;

-- Выбираем профили с сортировкой по дате рождения
SELECT * FROM profiles ORDER BY birthdate DESC LIMIT 10;

-- Выбираем лайки по типу пользователь
SELECT * FROM likes WHERE target_type_id = 2;

-- Объединяем, но так не работает
SELECT * FROM likes WHERE target_type_id = 2
  AND target_id IN (
    SELECT user_id FROM profiles ORDER BY birthdate DESC LIMIT 10
  );

-- Идём обходным путём
SELECT target_id, COUNT(*) FROM likes 
  WHERE target_type_id = 2
    AND target_id IN (SELECT * FROM (
      SELECT user_id FROM profiles ORDER BY birthdate DESC LIMIT 10
    ) AS sorted_profiles ) 
    GROUP BY target_id;

-- Суммируем для всех пользователей
SELECT SUM(likes_per_user) AS likes_total FROM ( 
  SELECT COUNT(*) AS likes_per_user 
    FROM likes 
      WHERE target_type_id = 2
        AND target_id IN (
          SELECT * FROM (
            SELECT user_id FROM profiles ORDER BY birthdate DESC LIMIT 10
          ) AS sorted_profiles 
        ) 
      GROUP BY target_id
) AS counted_likes;


  
