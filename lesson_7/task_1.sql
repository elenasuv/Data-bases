-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

CREATE DATABASE shop;
USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED,
  name VARCHAR(255) COMMENT 'Имя покупателя'
) COMMENT = 'Покупатели';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id INT UNSIGNED,
  user_id INT UNSIGNED
) COMMENT = 'Заказы';

ALTER TABLE users CHANGE id id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE orders CHANGE id id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY;

INSERT INTO users VALUES 
(DEFAULT, 'Ivanov Vasiliy'),
(DEFAULT, 'Rodionov Alexander'),
(DEFAULT, 'Sergeeva Olga'),
(DEFAULT, 'Komarova Svetlana'),
(DEFAULT, 'Petrov Ivan');

SELECT * FROM users;

INSERT INTO orders VALUES 
(DEFAULT, 5),
(DEFAULT, 1),
(DEFAULT, 3);

SELECT * FROM orders;

SELECT
  u.name 
FROM
  users AS u
JOIN
  orders AS o
ON
  u.id = o.user_id;










 

