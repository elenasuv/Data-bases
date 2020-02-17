-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT * FROM likes;
SELECT * FROM profiles;
-- Выбираем мужчин
SELECT user_id AS men 
FROM profiles 
WHERE sex = 'm';
-- Выбираем женщин
SELECT user_id AS women
FROM profiles 
WHERE sex = 'f';
-- Подсчитываем количество женщин, которые поставили лайки 
SELECT COUNT(*) AS women
FROM likes
  WHERE user_id IN (
 SELECT user_id 
  FROM profiles 
  WHERE sex = 'f');
-- Подсчитываем количество мужчин, которые поставили лайки  
SELECT COUNT(*) AS men
FROM likes
  WHERE user_id IN (
 SELECT user_id 
  FROM profiles 
  WHERE sex = 'm');
-- Сравним значения 
SELECT 
 (SELECT COUNT(*) AS women
FROM likes
  WHERE user_id IN (
 SELECT user_id 
  FROM profiles 
  WHERE sex = 'f')) >
 (SELECT COUNT(*) AS men
 FROM likes
  WHERE user_id IN (
 SELECT user_id 
  FROM profiles 
  WHERE sex = 'm')) AS 
 'Women>Men';
-- Как решил преподаватель  
SELECT CASE(sex)
		WHEN 'm' THEN 'man'
		WHEN 'f' THEN 'woman'
	END AS sex, 
	COUNT(*) as likes_count 
	  FROM (
	    SELECT 
	      user_id as user, 
		    (SELECT sex FROM profiles WHERE user_id = user) as sex 
		  FROM likes) dummy_table 
  GROUP BY sex
  ORDER BY likes_count DESC
  LIMIT 1;