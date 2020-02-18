-- В таблице products есть два текстовых поля: name с названием товара 
-- и description с его описанием. Допустимо присутствие обоих полей или одно из них.
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, 
-- добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

USE shop;
DESC products; 
SELECT * FROM products;
DROP TRIGGER IF EXISTS check_products_name_description_insert; 
DELIMITER //
CREATE TRIGGER check_products_name_description_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	DECLARE name_i VARCHAR(255);
    DECLARE description_i TEXT;
    SELECT name INTO name_i FROM products ORDER BY id DESC LIMIT 1;
    SELECT description INTO description_i FROM products ORDER BY id DESC LIMIT 1;
    SET NEW.name = COALESCE(NEW.name, name_i);
    SET NEW.description = COALESCE(NEW.description, description_i);
END //

  INSERT INTO products (
  price) VALUES
  ('15500');
 
INSERT INTO products (name, price) VALUES
('ASUS 5000', '17000');

 
  SELECT id, name, description, price FROM products;
 
DROP TRIGGER IF EXISTS check_products_name_description_update; 
DELIMITER //
CREATE TRIGGER check_products_name_description_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	DECLARE name_i VARCHAR(255);
    DECLARE description_i TEXT;
    SELECT name INTO name_i FROM products ORDER BY id DESC LIMIT 1;
    SELECT description INTO description_i FROM products ORDER BY id DESC LIMIT 1;
    SET NEW.name = COALESCE(NEW.name, OLD.name, name_i);
    SET NEW.description = COALESCE(NEW.description, OLD.description, description_i);
END //

UPDATE products SET name = NULL WHERE price = '17000';



 
