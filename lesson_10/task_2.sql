-- 2. Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе
-- самый пожилой пользователь в группе
-- общее количество пользователей в группе
-- всего пользователей в системе
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100
DESC communities;
DESC communities_users;
DESC profiles;

SELECT DISTINCT communities.name,
 AVG(count_com) AS average FROM (
  SELECT DISTINCT COUNT(communities_users.user_id)
   AS count_com
   FROM communities
      JOIN communities_users
        ON communities.id = communities_users.community_id
        GROUP BY communities.id
       ) AS count_by_com,
   FIRST_VALUE(communities_users.user_id) OVER(PARTITION BY communities.id ORDER BY profiles.birthdate DESC)
     AS youngest,
   FIRST_VALUE(communities_users.user_id) OVER(PARTITION BY communities.id ORDER BY profiles.birthdate) 
     AS oldest,
  COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) AS total_users_in_group,
  COUNT(profiles.user_id) OVER () AS total,
  COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) / COUNT(profiles.user_id) OVER () * 100 AS '%%'
    FROM profiles
      JOIN communities_users
        ON profiles.user_id = communities_users.user_id
      JOIN communities
        ON communities_users.community_id = communities.id;
       
       
       SELECT user_id FROM profiles ORDER BY birthdate DESC;
      
      
  SELECT
  AVG(count_com) AS average FROM (
  SELECT DISTINCT COUNT(communities_users.user_id) OVER(PARTITION BY communities_users.community_id)
   AS count_com
   FROM communities
      JOIN communities_users
        ON communities.id = communities_users.community_id
       ) AS count_by_com;
       

  SELECT
 AVG(count_com) AS average FROM (
  SELECT DISTINCT COUNT(communities_users.user_id)
   AS count_com
   FROM communities
      JOIN communities_users
        ON communities.id = communities_users.community_id
        GROUP BY communities.id
       ) AS count_by_com;

     
     
     
        
        
        
        
       
     
 
       
          
