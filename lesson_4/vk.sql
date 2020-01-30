-- Создаём БД
CREATE DATABASE vk;

-- Делаем её текущей
USE vk;

-- Создаём таблицу пользователей
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(15) NOT NULL UNIQUE,
  `password` VARCHAR(15),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица профилей
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL,
  birthdate DATE,
  sex CHAR(1) NOT NULL,
  hometown VARCHAR(100),
  country VARCHAR(100),
  photo_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица сообщений
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  is_important BOOLEAN,
  is_delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);

-- Таблица дружбы
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  status_id INT UNSIGNED NOT NULL,
  requested_at DATETIME DEFAULT NOW(),
  confirmed_at DATETIME,
  PRIMARY KEY (user_id, friend_id)
);

-- Таблица статусов дружеских отношений
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);


-- Таблица групп
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);

-- Таблица связи пользователей и групп
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (community_id, user_id)
);

-- Таблица медиафайлов
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  media_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица типов медиафайлов
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

-- Создаем значения таблицы media_types
INSERT INTO media_types VALUES 
(DEFAULT, 'photo'),
(DEFAULT, 'video'),
(DEFAULT, 'audio'),
(DEFAULT, 'game'),
(DEFAULT, 'doc');

-- Проверяем вставку сгенерированной таблицы
SELECT * FROM users;

-- Реализуем таблицу семейного положения
CREATE TABLE family_statuses (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (50) NOT NULL UNIQUE
);

-- Добавляем в столбец name значения
INSERT INTO family_statuses (name)
  VALUES
  ('Single'),
  ('Married')
 ;
-- Посмотрим структуру таблицы profiles
DESC profiles;

-- Добавляем столбец family_status_id в таблицу profiles
ALTER TABLE profiles ADD COLUMN family_status_id INT UNSIGNED AFTER hometown;
 
-- Заполняем весь столбец family_status_id случайными числами от 1 до 2
UPDATE profiles SET family_status_id = FLOOR(1 + (RAND() * 2));

-- Проверяем таблицу profiles
SELECT * FROM profiles LIMIT 10;

-- Смотрим структуру таблицы users
DESC users;

-- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE users SET updated_at = created_at WHERE updated_at < created_at;

-- Смотрим структуру таблицы profiles
DESC profiles;

-- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE profiles SET updated_at = created_at WHERE updated_at < created_at;

-- Корректируем столбец birthdate, чтобы создание не происходило раньше, чем дата рождения
UPDATE profiles SET birthdate = created_at WHERE birthdate > created_at;

-- Удаляем столбец user_id из таблицы profiles
ALTER TABLE profiles DROP COLUMN user_id;

-- Добавляем столбец user_id 
ALTER TABLE profiles ADD COLUMN user_id INT UNSIGNED NOT NULL FIRST;

-- Добавляем столбцу user_id статус первичного ключа. Нам не удается это сделать, так как столбец заполнился нулями
ALTER TABLE profiles ADD PRIMARY KEY(user_id);

-- Обновляем таблицу profiles и заполняем столбец user_id числами от 1 до 100. Но таким образом мы не исключаем повторения чисел.
UPDATE profiles SET user_id = FLOOR(1 + (RAND() * 100));

-- Удаляем столбец user_id из таблицы profiles
ALTER TABLE profiles DROP COLUMN user_id;

-- Добавляем столбец user_id с атрибутами auto_increment и primary key 
ALTER TABLE profiles ADD COLUMN user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL FIRST;

-- Избавимся от признака auto_increment, так как числа в user_id необязательно должны идти по порядку. user_id связан с id таблицы users
  ALTER TABLE profiles MODIFY COLUMN user_id INT UNSIGNED UNIQUE;
 
 -- Создадим таблицу постов
 CREATE TABLE posts (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   author_id INT UNSIGNED NOT NULL,
   body TEXT NOT NULL,
   media_id INT UNSIGNED NOT NULL,
   created_at DATETIME DEFAULT NOW()
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
 );

-- Удалим таблицу постов
DROP TABLE posts;

-- Создадим таблицу постов
 CREATE TABLE posts (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   author_id INT UNSIGNED NOT NULL,
   body TEXT NOT NULL,
   media_id INT UNSIGNED NOT NULL,
   created_at DATETIME DEFAULT NOW(),
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
  );
 
 -- Добавляем столбцы в таблицу communities
ALTER TABLE communities ADD COLUMN web VARCHAR(300) NOT NULL AFTER name;
ALTER TABLE communities ADD COLUMN created_at DATETIME DEFAULT NOW() AFTER web;
ALTER TABLE communities ADD COLUMN updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() AFTER created_at;

-- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE communities SET updated_at = created_at WHERE updated_at < created_at;

-- Посмотрим данные таблицы users
SELECT * FROM users LIMIT 10;


-- Посмотрим данные таблицы profiles
SELECT * FROM profiles LIMIT 10;

-- Посмотрим данные таблицы messages
SELECT * FROM messages LIMIT 10;

-- Добиваемся исключения повторения значений to_user_id и from_user_id
UPDATE messages SET to_user_id = to_user_id + 1 WHERE from_user_id = to_user_id;

-- Посмотрим данные таблицы media
SELECT * FROM media LIMIT 10;

-- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE media SET updated_at = created_at WHERE updated_at < created_at;

-- Заполним столбец user_id случайными значениями
UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));

-- Изменим значения столбца filename
UPDATE media SET filename = CONCAT('http://dropbox/vk/file_', metadata);

-- Изменяем значения столбца metadata
UPDATE media SET metadata = CONCAT(
  '{"',
  'owner',
  '":"',
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');
 
 -- Посмотрим данные таблицы friendship
SELECT * FROM friendship LIMIT 10;

-- Заполним столбец user_id случайными значениями
UPDATE friendship SET user_id = FLOOR(1 + (RAND() * 100));

-- Добиваемся исключения повторения значений user_id и friend_id
UPDATE friendship SET user_id = user_id + 1 WHERE user_id = friend_id;

-- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE friendship SET requested_at = confirmed_at WHERE confirmed_at < requested_at;

-- Посмотрим данные таблицы friendship_statuses
SELECT * FROM friendship_statuses LIMIT 10;

-- Удалим значения таблицы friendship_statuses
TRUNCATE friendship_statuses;

-- Добавляем в столбец name значения
INSERT INTO friendship_statuses (name)
  VALUES
  ('Confirmed'),
  ('Rejected'),
  ('Requested')
 ;

-- Заполним столбец status_id случайными значениями
UPDATE friendship SET status_id = FLOOR(1 + (RAND() * 3));

-- Смотрим структуру таблицы media
DESC media;

-- Изменим тип столбца metadata
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- Посмотрим данные таблицы communities
SELECT * FROM communities LIMIT 10;

-- Ограничим количество communities до 10
DELETE FROM communities WHERE id > 10;

-- Посмотрим данные таблицы communities_users
SELECT * FROM communities_users;

-- Заполним столбец community_id случайными значениями
UPDATE communities_users SET 
  community_id = FLOOR(1 + (RAND() * 10))
 ;

-- Проверяем таблицу family_statuses
SELECT * FROM family_statuses;

-- Проверяем таблицу posts
SELECT * FROM posts;
-- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE posts SET updated_at = created_at WHERE updated_at < created_at;

-- Создаем таблицу лайков медиа
CREATE TABLE likes_media (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id INT UNSIGNED NOT NULL,
media_id INT UNSIGNED,
created_at DATETIME DEFAULT NOW()
);

-- Создаем таблицу лайков постов
CREATE TABLE likes_posts (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id INT UNSIGNED NOT NULL,
post_id INT UNSIGNED,
created_at DATETIME DEFAULT NOW()
);

-- Создаем таблицу лайков сообществ
CREATE TABLE likes_communities (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id INT UNSIGNED NOT NULL,
community_id INT UNSIGNED,
created_at DATETIME DEFAULT NOW()
);

-- Проверяем таблицу лайков медиа
SELECT * FROM ;

-- Проверяем таблицу лайков постов
SELECT * FROM likes_posts;

-- Проверяем таблицу лайков сообществ
SELECT * FROM likes_communities;

-- Удаляем вариант реализации лайков

DROP TABLE likes_media;

DROP TABLE likes_posts;

DROP TABLE likes_communities;

DROP TABLE IF EXISTS likes;

-- Создаем таблицу лайков
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Таблица типов лайков
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- Заполняем таблицу типов таргетов
INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');
 
 -- Заполняем лайки
INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;

-- Проверим
SELECT * FROM likes LIMIT 10;

-- Смотрим структуру users и profiles
DESC users;
DESC profiles;
-- Выбираем пользователя
SELECT 
  first_name, last_name, 
  'main photo', 
  'city' 
    FROM users WHERE id = 3;
-- Путь к id фотографии  
SELECT photo_id FROM profiles WHERE user_id =3;

-- Смотрим структуру media
DESC media;

-- Скопируем путь к id в запрос
SELECT filename FROM media WHERE id =
  (SELECT photo_id FROM profiles WHERE user_id =3);
 
-- Вставляем запрос выше в заглушку 'main photo'
SELECT 
  first_name, last_name, 
  (SELECT filename FROM media WHERE id =
    (SELECT photo_id FROM profiles WHERE user_id =3)) AS filename, 
  'city' 
    FROM users WHERE id = 3;
   
-- Получим город
SELECT hometown FROM profiles WHERE user_id = 3;

-- Встявляем город в общий запрос
SELECT 
  first_name, last_name, 
  (SELECT filename FROM media WHERE id =
    (SELECT photo_id FROM profiles WHERE user_id = 3)) AS filename, 
  (SELECT hometown FROM profiles WHERE user_id = 3) AS hometown 
    FROM users WHERE id = 3;

-- Корректируем запрос. Уберем повторяющиеся id пользователя
SELECT 
  first_name, last_name, 
  (SELECT filename FROM media WHERE id =
    (SELECT photo_id FROM profiles WHERE user_id = users.id)) AS filename, 
  (SELECT hometown FROM profiles WHERE user_id = users.id) AS hometown 
    FROM users WHERE id = 3;
   
-- Получим все фотографии пользователя
SELECT * FROM media_types;

SELECT filename FROM media
  WHERE user_id = 3
    AND media_type_id = (
        SELECT id FROM media_types WHERE name = 'photo'
      );
     
-- Либо можно по id фото получить такой же результат
SELECT filename FROM media
  WHERE user_id = 3
    AND media_type_id = 1;
   
-- Выбираем историю по добавлению фотографий пользователем
SELECT CONCAT(
  'Пользователь добавил фото ', 
  filename, 
  ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 3 
      AND media_type_id = (
        SELECT id FROM media_types WHERE name LIKE 'photo'
);

-- Улучшаем запрос, чтобы видеть пользователя
SELECT CONCAT(
  'Пользователь ', 
  (SELECT CONCAT(first_name, ' ', last_name)
    FROM users WHERE id = media.user_id),
  ' добавил фото ', 
  filename, ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 3 
      AND media_type_id = (
        SELECT id FROM media_types WHERE name LIKE 'photo'
);

-- Найти пользователей, кому принадлежат 10 самых тяжелых файлов
-- Сначала выбираем следующее
SELECT user_id, filename, size
  FROM media 
  ORDER BY size DESC
  LIMIT 10;

-- Найдем имена пользователей
SELECT
  (SELECT CONCAT(first_name, ' ', last_name)
    FROM users u
      WHERE u.id = m.user_id) AS owner,
  filename,
  size
    FROM media m
    ORDER BY size DESC
    LIMIT 10;
   
-- Cтруктура friendship
DESC friendship;

-- Найдем друзей нашего конкретного пользователя
SELECT friend_id FROM friendship WHERE user_id = 3;
SELECT user_id FROM friendship WHERE friend_id = 3;

-- Объединяем запросы
(SELECT friend_id FROM friendship WHERE user_id = 3) 
   UNION
(SELECT user_id FROM friendship WHERE friend_id = 3);

-- Смотрим таблицу статусов
SELECT * FROM friendship_statuses;

-- Добавим условие по статусу дружбы
(SELECT friend_id 
  FROM friendship 
  WHERE user_id = 4
    AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name = 'Confirmed'
    )
)
UNION
(SELECT user_id 
  FROM friendship 
  WHERE friend_id = 4
    AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name = 'Confirmed'
    )
);

-- Выберем медиафайлы друзей
SELECT filename FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 4
    AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name = 'Confirmed'
    )
  )
  UNION
  (SELECT user_id 
    FROM friendship 
    WHERE friend_id = 4 
      AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name = 'Confirmed'
    )
  )
);

-- Объединяем медиафайлы пользователя и его друзей для создания ленты новостей
SELECT filename, user_id, created_at FROM media WHERE user_id = 4
UNION
SELECT filename, user_id, created_at FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 4
    AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name = 'Confirmed'
    )
  )
  UNION
  (SELECT user_id 
    FROM friendship 
    WHERE friend_id = 4 
      AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name = 'Confirmed'
    )
  )
);

-- Определяем пользователей, общее занимаемое место медиафайлов которых 
-- превышает 100МБ
SELECT user_id, SUM(size) AS total
  FROM media
  GROUP BY user_id
  HAVING total > 100000000
  ORDER BY total DESC;
 
-- Подсчитываем лайки для медиафайлов пользователя и его друзей
SELECT target_id AS mediafile, COUNT(*) AS likes 
  FROM likes 
    WHERE target_id IN (
      SELECT id FROM media WHERE user_id = 4
        UNION
      (SELECT id FROM media WHERE user_id IN (
        SELECT friend_id 
          FROM friendship 
            WHERE user_id = 4 
              AND status_id IN (
                SELECT id FROM friendship_statuses 
                  WHERE name = 'Confirmed'
              )))
        UNION
      (SELECT id FROM media WHERE user_id IN (
        SELECT user_id 
          FROM friendship 
            WHERE friend_id = 4 
              AND status_id IN (
                SELECT id FROM friendship_statuses 
                  WHERE name = 'Confirmed'
              ))) 
    )
    AND target_type_id = (SELECT id FROM target_types WHERE name = 'media')
    GROUP BY target_id;
   
-- Начинаем создавать архив новостей для медиафайлов по месяцам
SELECT COUNT(id) AS arhive, MONTHNAME(created_at) AS month 
  FROM media
  GROUP BY month;
 
SET sql_mode = '';
 
-- Архив с правильной сортировкой новостей по месяцам
SELECT COUNT(id) AS news, 
  MONTHNAME(created_at) AS month,
  MONTH(created_at) AS month_num 
    FROM media
      WHERE YEAR(created_at) = YEAR(NOW())
    GROUP BY month_num
    ORDER BY month_num DESC;

SELECT COUNT(id) AS news, 
  MONTHNAME(created_at) AS month,
  MONTH(created_at) AS month_num  
    FROM media
    GROUP BY month_num
    ORDER BY month_num DESC;
    
SELECT COUNT(id) AS news, 
  MONTHNAME(created_at) AS month
    FROM media
    GROUP BY MONTH(created_at)
    ORDER BY MONTH(created_at) DESC;  

-- Выбираем сообщения от пользователя и к пользователю
SELECT from_user_id, to_user_id, body, is_delivered, created_at 
  FROM messages
    WHERE from_user_id = 3
      OR to_user_id = 3
    ORDER BY created_at DESC;
   
-- Непрочитанные сообщения
SELECT from_user_id, 
  to_user_id, 
  body, 
  IF(is_delivered, 'delivered', 'not delivered') AS status 
    FROM messages
      WHERE (from_user_id = 3 OR to_user_id = 3)
    ORDER BY created_at DESC;
   
-- Выводим друзей пользователя с преобразованием пола и возраста 
SELECT 
    (SELECT CONCAT(first_name, ' ', last_name) 
      FROM users 
      WHERE id = user_id) AS friend,  
    CASE (sex)
      WHEN 'm' THEN 'man'
      WHEN 'f' THEN 'women'
    END AS sex,
    TIMESTAMPDIFF(YEAR, birthdate, NOW()) AS age   
  FROM profiles
  WHERE user_id IN (
    SELECT friend_id 
      FROM friendship
      WHERE user_id = 4
        AND confirmed_at IS NOT NULL
        AND status_id IN (
          SELECT id FROM friendship_statuses 
            WHERE name = 'Confirmed')
  UNION
      SELECT user_id 
      FROM friendship
      WHERE friend_id = 4
        AND confirmed_at IS NOT NULL
        AND status_id IN (
          SELECT id FROM friendship_statuses 
            WHERE name = 'Confirmed')
  );
 
-- Поиск пользователя по шаблонам имени  
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  WHERE first_name LIKE 'M%';
 
-- Используем регулярные выражения
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  WHERE last_name RLIKE '^M.*n$';




  
   




 










 





 
 

 





 