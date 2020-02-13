-- 5.(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

CREATE DATABASE task_5;

USE task_5;

CREATE TABLE catalogs (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

INSERT INTO catalogs
VALUES
(DEFAULT, 'Процессоры'),
(DEFAULT, 'Материнские платы'),
(DEFAULT, 'Видеокарты'),
(DEFAULT, 'Жесткие диски'),
(DEFAULT, 'Оперативная память');

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD (id, 5, 1, 2);