-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
-- catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы,
-- идентификатор первичного ключа и содержимое поля name.

CREATE TABLE logs (
id INT,
table_name VARCHAR(255),
field_name VARCHAR(255),
created_at DATETIME
) ENGINE=Archive;

SELECT * FROM users;
SELECT * FROM catalogs;
SELECT * FROM products; 


DELIMITER //
CREATE TRIGGER tables_logs AFTER INSERT ON users
FOR EACH ROW 
BEGIN
INSERT INTO logs(id, table_name, field_name, created_at) SELECT id, 'users', name, CURRENT_TIMESTAMP  
FROM users WHERE id = NEW.id;	
END//

INSERT INTO users VALUES
(DEFAULT, 'Maxim Egorov');

SELECT * FROM logs; 

DELIMITER //
CREATE TRIGGER tables_logs_1 AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN
INSERT INTO logs(id, table_name, field_name, created_at) SELECT id, 'catalogs', name, CURRENT_TIMESTAMP  
FROM catalogs WHERE id = NEW.id;	
END//

INSERT INTO catalogs VALUES
(DEFAULT, 'опер.память');

DELIMITER //
CREATE TRIGGER tables_logs_2 AFTER INSERT ON products
FOR EACH ROW 
BEGIN
INSERT INTO logs(id, table_name, field_name, created_at) SELECT id, 'products', name, CURRENT_TIMESTAMP  
FROM products WHERE id = NEW.id;	
END//

INSERT INTO products VALUES
(DEFAULT, 'Intel Core i7', 'Процессор для настольных компьютеров, основанных на платформе Intel.',
6000, 1, DEFAULT, DEFAULT);
