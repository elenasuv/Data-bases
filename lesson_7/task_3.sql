-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

CREATE DATABASE airport;
USE airport;

CREATE TABLE flights (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `from` VARCHAR (100) NOT NULL,
  `to` VARCHAR (100) NOT NULL
);

INSERT INTO flights VALUES
  (DEFAULT, 'moscow', 'omsk'),
  (DEFAULT, 'novgorod', 'kazan'),
  (DEFAULT, 'irkutsk', 'moscow'),
  (DEFAULT, 'omsk', 'irkutsk'),
  (DEFAULT, 'moscow', 'kazan');
  
SELECT * FROM flights;

CREATE TABLE cities (
  label VARCHAR (100) NOT NULL,
  name  VARCHAR (100) NOT NULL 
);

INSERT INTO cities VALUES
  ('moscow', 'москва'),
  ('irkutsk', 'иркутск'),
  ('novgorod', 'новгород'),
  ('kazan', 'казань'),
  ('omsk', 'омск');
 
 SELECT * FROM cities;


SELECT cities.name
   FROM 
   flights
   JOIN
   cities
   ON
   flights.`from` = cities.label;
  
SELECT cities.name
   FROM 
   flights
   JOIN
   cities
   ON
   flights.`to` = cities.label;
  
  
