-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

 SELECT CASE(sex)
		WHEN 'm' THEN 'man'
		WHEN 'f' THEN 'woman'
	END AS sex, 
	COUNT(*) as likes_count 
	  FROM profiles
	    JOIN likes 
	  ON profiles.user_id = likes.user_id
	  GROUP BY profiles.sex
	  ORDER BY likes_count DESC
  LIMIT 1;
	    
	  
	    