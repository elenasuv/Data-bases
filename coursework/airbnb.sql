-- База данных сайта по бронированию жилья airbnb.ru состоит из 14 таблиц. Все таблицы приведены к нормальной форме.
-- Структура БД включает в себя основной функционал сайта. В составе базы данных есть 2 таблицы связи. 
-- Одна из них таблица закладок, которая связывает id пользователей и жилья. Эта таблица хранит понравившиеся пользователям 
-- варианты жилья. Вторая таблица связи - таблица связи id фото и жилья. Таблица дает информацию, какие фото, относятся 
-- именно к вариантам жилья. БД позволяет производить неплохую аналитику. Примеры решаемых задач представлены
-- ниже. 
-- Создаём БД
CREATE DATABASE airbnb;

-- Делаем её текущей
USE airbnb;

-- Таблица пользователей
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(15) NOT NULL UNIQUE,
  `password` VARCHAR(15),
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Таблица аккаунтов
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL UNIQUE,
  birthdate DATE,
  sex CHAR(1) NOT NULL,
  country_id INT UNSIGNED NOT NULL, 
  city_id INT UNSIGNED NOT NULL,
  photo_id INT UNSIGNED,
  social_net_facebook_status_id INT UNSIGNED NOT NULL,
  social_net_google_status_id INT UNSIGNED NOT NULL,
  status_superowner BOOLEAN, 
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Таблица стран
CREATE TABLE countries (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR (255) NOT NULL UNIQUE 
);

-- Таблица городов
CREATE TABLE cities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR (255) NOT NULL UNIQUE 
);

-- Таблица статусов связанных соцсетей
CREATE TABLE social_net_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR (50) NOT NULL UNIQUE
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

-- Таблица жилья
CREATE TABLE housing (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  owner_id INT UNSIGNED NOT NULL,
  name VARCHAR (255) NOT NULL,
  country_id INT UNSIGNED NOT NULL, 
  city_id INT UNSIGNED NOT NULL,
  address TEXT NOT NULL,
  housing_type_id INT UNSIGNED NOT NULL, 
  description TEXT,
  price_per_day DECIMAL (11,2),
  rating TINYINT UNSIGNED 
);

-- Таблица типов жилья
CREATE TABLE housing_types (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (255) NOT NULL
);

-- Таблица закладок пользователей
CREATE TABLE favourites (
  housing_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (housing_id, user_id)
);

-- Таблица фото
CREATE TABLE  photos (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Таблица связи фото и жилья
CREATE TABLE housing_photos (
  housing_id INT UNSIGNED NOT NULL,
  photo_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (housing_id, photo_id)
); 

-- Таблица отзывов
CREATE TABLE feedbacks (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  housing_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Таблица поездок
CREATE TABLE journeys (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  housing_id INT UNSIGNED NOT NULL,
  arrival_date DATETIME,
  departure_date DATETIME,
  pay_information_id INT UNSIGNED NOT NULL, 
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Таблица информации по статусу платежа
CREATE TABLE pay_information_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR (50) NOT NULL UNIQUE
);

-- Заполняем таблицу статусов связанных соцсетей
INSERT INTO social_net_statuses (name)
  VALUES
  ('Connected'),
  ('Not connected');

 -- Заполняем таблицу по статусу платежа
INSERT INTO pay_information_statuses (name)
  VALUES
  ('Paid'),
  ('Not paid');
 
 -- Заполняем таблицу типов жилья
INSERT INTO housing_types (name)
  VALUES
  ('house'),
  ('flat'),
  ('villa'),
  ('hostel'),
  ('bungalow');
 
 -- Смотрим таблицы базы данных airbnb
SHOW TABLES;

 -- Проверяем таблицу housing
SELECT * FROM housing;

 -- Изменим тип столбца rating таблицы housing
ALTER TABLE housing MODIFY COLUMN rating DECIMAL(2,1) UNSIGNED;

 -- Заполняем весь столбец rating случайными числами от 0 до 5
UPDATE housing SET rating = (RAND() * 5);

 -- Проверяем таблицу users
SELECT * FROM users LIMIT 10;

-- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE users SET updated_at = created_at WHERE updated_at < created_at;

 -- Проверяем таблицу profiles
SELECT * FROM profiles LIMIT 10;

-- Обновляем таблицу profiles и заполняем столбец social_net_facebook_status_id числами от 1 до 2. 
UPDATE profiles SET social_net_facebook_status_id = FLOOR(1 + (RAND() * 2));

-- Обновляем таблицу profiles и заполняем столбец social_net_google_status_id числами от 1 до 2. 
UPDATE profiles SET social_net_google_status_id = FLOOR(1 + (RAND() * 2));

-- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE profiles SET updated_at = created_at WHERE updated_at < created_at;

-- Корректируем столбец birthdate, чтобы создание не происходило раньше, чем дата рождения
UPDATE profiles SET birthdate = created_at WHERE birthdate > created_at;

 -- Обновляем таблицу profiles и заполняем столбец country_id числами от 1 до 100. 
UPDATE profiles SET country_id = FLOOR(1 + (RAND() * 100));

-- Обновляем таблицу profiles и заполняем столбец city_id числами от 1 до 100. 
UPDATE profiles SET city_id = FLOOR(1 + (RAND() * 100));

-- Сделаем значения photo_id уникальными
ALTER TABLE profiles MODIFY COLUMN photo_id INT UNSIGNED UNIQUE;

-- Проверяем таблицу countries
SELECT * FROM countries LIMIT 10;

-- Проверяем таблицу cities
SELECT * FROM cities;

-- Проверяем таблицу social_net_statuses 
SELECT * FROM social_net_statuses;

-- Проверяем таблицу messages 
SELECT * FROM messages LIMIT 10;

-- Добиваемся исключения повторения значений to_user_id и from_user_id
UPDATE messages SET to_user_id = to_user_id + 1 WHERE from_user_id = to_user_id;

-- Проверяем таблицу housing
SELECT * FROM housing LIMIT 10;

-- Исключаем возможность нулевой стоимости жилья
UPDATE housing SET price_per_day = (100 + (RAND() * 500000));

-- Проверяем таблицу housing_types
SELECT * FROM housing_types;

-- Проверяем таблицу favourites
SELECT * FROM favourites;

-- Проверяем таблицу photos
SELECT * FROM photos LIMIT 10;

-- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE photos SET updated_at = created_at WHERE updated_at < created_at;

-- Заполним столбец user_id случайными значениями
UPDATE photos SET user_id = FLOOR(1 + (RAND() * 100));

-- Изменим значения столбца filename
UPDATE photos SET filename = CONCAT('http://dropbox/airbnb/file_', metadata);

-- Изменяем значения столбца metadata
UPDATE photos SET metadata = CONCAT(
  '{"',
  'owner',
  '":"',
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');
 
 -- Проверяем таблицу housing_photos
SELECT * FROM housing_photos;

-- Удалим значения таблицы housing_photos
TRUNCATE housing_photos;

-- Сделаем значения photo_id уникальными
ALTER TABLE housing_photos MODIFY COLUMN photo_id INT UNSIGNED UNIQUE;

-- Проверяем таблицу feedbacks
SELECT * FROM feedbacks;

-- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE feedbacks SET updated_at = created_at WHERE updated_at < created_at;

-- Добиваемся исключения повторения значений to_user_id и from_user_id
UPDATE feedbacks SET to_user_id = to_user_id + 1 WHERE from_user_id = to_user_id;

-- Проверяем таблицу journeys
SELECT * FROM journeys;

-- Заполним столбец user_id случайными значениями
UPDATE journeys SET user_id = FLOOR(1 + (RAND() * 100));

 -- Заполним столбец housing_id случайными значениями
UPDATE journeys SET housing_id = FLOOR(1 + (RAND() * 60));

-- Корректируем столбцы arrival_date и departure_date, чтобы отъезд не происходил раньше, чем приезд
UPDATE journeys SET departure_date = arrival_date WHERE departure_date < arrival_date;

UPDATE journeys SET departure_date = DATE_ADD(arrival_date, INTERVAL 7 DAY);

 -- Корректируем столбцы created_at и updated_at, чтобы обновление не происходило раньше, чем создание
UPDATE journeys SET updated_at = created_at WHERE updated_at < created_at;

-- Проверяем таблицу pay_information_statuses
SELECT * FROM pay_information_statuses;


-- Определяем, из какой страны больше всего пользователей сайта

SELECT * FROM profiles; 

SELECT (SELECT name FROM countries WHERE id = profiles.country_id) AS country, 
COUNT(*) AS total 
  FROM profiles
  GROUP BY country
  ORDER BY total DESC
  LIMIT 1;
 
-- Определяем средний возраст пользователей сайта
SELECT
 FLOOR(AVG(TIMESTAMPDIFF(YEAR, birthdate, NOW()))) AS average_age
FROM
  profiles;
 
-- Определяем 10 самых дорогих городов по стоимости жилья
SELECT * FROM profiles LIMIT 10;
SELECT * FROM housing;

SELECT (SELECT name FROM cities WHERE id = housing.city_id) AS city,
  AVG(price_per_day) AS price
FROM 
  housing
  GROUP BY city
  ORDER BY price DESC
  LIMIT 10;
 
-- Определим, кто больше снимает жилье - мужчины или женщины?

 SELECT * FROM journeys; 

SELECT CASE(sex)
		WHEN 'M' THEN 'man'
		WHEN 'F' THEN 'woman'
	END AS sex, 
	COUNT(*) as journey_count
	  FROM (
	    SELECT 
	      user_id as user, 
		    (SELECT sex FROM profiles WHERE user_id = user) as sex 
		  FROM journeys) dummy_table 
  GROUP BY sex
  ORDER BY journey_count DESC
  LIMIT 1;
 
-- Найдем самое популярное жилье в апреле 1974 в North Angelica
SELECT (SELECT name FROM housing WHERE id = housing_id) AS house,
  COUNT(*) AS journey_count
  FROM journeys
    WHERE housing_id IN (SELECT id FROM housing WHERE city_id =
          (SELECT id FROM cities
          WHERE name = 'North Angelica')
          AND   
      MONTH(arrival_date) = 4 AND YEAR(arrival_date) = 1974
      AND MONTH(departure_date) = 4 AND YEAR(departure_date) = 1974)
       GROUP BY house
       ORDER BY journey_count DESC
       LIMIT 1;
 
-- Добавляем внешние ключи к базе данных airbnb
-- Для таблицы аккаунтов

-- Смотрим структуру таблицы
DESC profiles;

-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_country_id_fk
    FOREIGN KEY (country_id) REFERENCES countries(id)
    ON DELETE RESTRICT,
  ADD CONSTRAINT profiles_city_id_fk
    FOREIGN KEY (city_id) REFERENCES cities(id)
    ON DELETE RESTRICT,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES photos(id)
    ON DELETE SET NULL,    
  ADD CONSTRAINT profiles_social_net_facebook_status_id_fk
    FOREIGN KEY (social_net_facebook_status_id) REFERENCES social_net_statuses(id)
    ON DELETE RESTRICT,
  ADD CONSTRAINT profiles_social_net_google_status_id_fk
    FOREIGN KEY (social_net_google_status_id) REFERENCES social_net_statuses(id)
    ON DELETE RESTRICT;
   
-- Для таблицы сообщений
   
-- Смотрим структуру таблицы
DESC messages;

-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);
   
-- Для таблицы жилья
-- Смотрим структуру таблицы
DESC housing;

-- Добавляем внешние ключи
ALTER TABLE housing
  ADD CONSTRAINT housing_owner_id_fk 
    FOREIGN KEY (owner_id) REFERENCES users(id),
  ADD CONSTRAINT housing_country_id_fk
    FOREIGN KEY (country_id) REFERENCES countries(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT housing_city_id_fk
    FOREIGN KEY (city_id) REFERENCES cities(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT housing_housing_type_id_fk
    FOREIGN KEY (housing_type_id) REFERENCES housing_types(id)
      ON DELETE CASCADE   
      ON UPDATE CASCADE;
     
-- Для таблицы закладок пользователей
-- Смотрим структуру таблицы
DESC favourites;

-- Добавляем внешние ключи
ALTER TABLE favourites
  ADD CONSTRAINT favourites_housing_id_fk 
    FOREIGN KEY (housing_id) REFERENCES housing(id),
  ADD CONSTRAINT favourites_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);  
       
-- Для таблицы фото
-- Смотрим структуру таблицы
DESC photos;
-- Добавляем внешние ключи
ALTER TABLE photos
  ADD CONSTRAINT photos_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
   
-- Для таблицы связи фото и жилья
-- Смотрим структуру таблицы
DESC housing_photos;
-- Добавляем внешние ключи
ALTER TABLE housing_photos 
  ADD CONSTRAINT housing_photos_housing_id_fk 
    FOREIGN KEY (housing_id) REFERENCES housing(id),  
  ADD CONSTRAINT housing_photos_photo_id_fk 
    FOREIGN KEY (photo_id) REFERENCES photos(id);
 
-- Для таблицы отзывов
-- Смотрим структуру таблицы
DESC feedbacks;
-- Добавляем внешние ключи
ALTER TABLE feedbacks
  ADD CONSTRAINT feedbacks_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT feedbacks_to_user_id_fk  
    FOREIGN KEY (to_user_id) REFERENCES users(id),
  ADD CONSTRAINT feedbacks_housing_id_fk  
    FOREIGN KEY (housing_id) REFERENCES housing(id);
 
-- Для таблицы поездок
-- Смотрим структуру таблицы
DESC journeys;
-- Добавляем внешние ключи
ALTER TABLE journeys
  ADD CONSTRAINT journeys_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT journeys_housing_id_fk 
    FOREIGN KEY (housing_id) REFERENCES housing(id),     
  ADD CONSTRAINT journeys_pay_information_id_fk 
    FOREIGN KEY (pay_information_id) REFERENCES pay_information_statuses(id)       
      ON DELETE RESTRICT;
     
     
-- Определяем 10 пользователей, сдающих жилье, с наибольшим количеством закладок у пользователей
SELECT * FROM housing LIMIT 10;
SELECT * FROM favourites LIMIT 10;

SELECT housing.owner_id, first_name, last_name, COUNT(*) AS total_favourite
  FROM users
    JOIN housing
      ON users.id = housing.owner_id
    JOIN favourites
      ON housing.id = favourites.housing_id
  GROUP BY housing.owner_id
  ORDER BY total_favourite DESC
  LIMIT 10;
 -- Проверка
 SELECT id FROM housing WHERE owner_id = 6;
 SELECT housing_id, COUNT(*) AS total FROM favourites GROUP BY housing_id ORDER BY total DESC;
    
         
-- Определяем 10 страна, где больше всего предложений по жилью
SELECT * FROM countries;
SELECT * FROM housing LIMIT 10;

SELECT countries.name, COUNT(*) AS housing_count
  FROM countries
    JOIN housing
      ON countries.id = housing.country_id
  GROUP BY countries.name
  ORDER BY housing_count DESC
  LIMIT 10;

 -- Проверка
 SELECT id FROM countries WHERE name = 'Mongolia';
 SELECT id FROM housing WHERE country_id = 82;

-- Создаем представление, которое выводит название жилья, имя и фамилию владельца, страну, город и тип жилья 
CREATE OR REPLACE VIEW common_housing AS
SELECT
  housing.name AS housing,
  (SELECT CONCAT(first_name,' ', last_name) FROM users
    WHERE id = housing.owner_id) AS owner,
  countries.name AS country,
  cities.name AS city,
  housing_types.name AS housing_type  
FROM housing   
  JOIN countries
    ON housing.country_id = countries.id 
  JOIN cities
    ON housing.city_id = cities.id
  JOIN housing_types
    ON housing.housing_type_id = housing_types.id;
   
SELECT * FROM common_housing;

-- Создаем представление, которое выводит имя и фамилию пользователя в отсортированном порядке, страну, город
CREATE OR REPLACE VIEW sorted_users AS
SELECT 
   users.last_name AS user_last_name,
   users.first_name AS user_first_name,
   countries.name AS country,
   cities.name AS city
   FROM users
     JOIN profiles
       ON users.id = profiles.user_id
     JOIN countries
       ON profiles.country_id = countries.id
     JOIN cities
       ON profiles.city_id = cities.id
   ORDER BY user_last_name;

SELECT * FROM sorted_users;

-- Создаём процедуру
-- Рассылка вида "Возможно, вам будет интересно посетить страны..." по закладкам пользователей.
-- Из выборки показывать 2 страны в случайной комбинации.

DROP PROCEDURE IF EXISTS country_offers;
DELIMITER -
CREATE PROCEDURE country_offers (IN for_user_id INT)
  BEGIN 
    (
      SELECT countries.name
        FROM countries
          JOIN housing
            ON countries.id = housing.country_id
          JOIN favourites
            ON favourites.housing_id = housing.id
          JOIN users
            ON favourites.user_id = users.id
         WHERE favourites.user_id = for_user_id
      )          
    ORDER BY RAND()
    LIMIT 2;     
END; -  
DELIMITER ;

CALL country_offers(55);

-- Создадим триггеры на INSERT и DELETE, в которых мы извлечем количество записей в таблице housing
DELIMITER -
CREATE TRIGGER housing_count AFTER INSERT ON housing
FOR EACH ROW
BEGIN
	SELECT COUNT(*) INTO @total FROM housing;
END -

CREATE TRIGGER housing_count AFTER DELETE ON housing
FOR EACH ROW
BEGIN
	SELECT COUNT(*) INTO @total FROM housing;
END -

DELIMITER ;

-- Создаем уникальный индекс на столбец email
CREATE UNIQUE INDEX users_email_uq ON users(email);

-- Создаем индекс на столбец birthdate
CREATE INDEX profiles_birthdate_idx ON profiles(birthdate);

-- Создаем индекс на столбец size
CREATE INDEX photos_size_idx ON photos(size);

-- Создадим составной индекс sex и birthdate
CREATE INDEX profiles_sex_profiles_birthdate_idx ON profiles(sex, birthdate);

-- Создаем индекс на столбец last_name
CREATE INDEX users_last_name_idx ON users(last_name);

-- Создаем уникальный индекс на столбец name таблицы cities
CREATE UNIQUE INDEX cities_name_uq ON cities(name);

-- Создаем уникальный индекс на столбец name таблицы countries
CREATE UNIQUE INDEX countries_name_uq ON countries(name);

















