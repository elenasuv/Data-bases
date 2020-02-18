-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
   
   SELECT SUM(likes_per_user) AS likes_total FROM (   
   SELECT COUNT(DISTINCT likes.id) AS likes_per_user
  FROM users
    LEFT JOIN likes
      ON users.id = likes.target_id
    JOIN profiles
      ON likes.target_id = profiles.user_id
    JOIN target_types
      ON likes.target_type_id = target_types.id
    WHERE target_types.id = 2 AND likes.target_id IN (SELECT * FROM (
      SELECT profiles.user_id ORDER BY profiles.birthdate DESC LIMIT 10)
        AS sorted_profiles)
  GROUP BY likes.target_id) AS counted_likes;
  
 
 
 
         
    
         
       
         
     
