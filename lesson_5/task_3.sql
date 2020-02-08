-- � ������� ��������� ������� storehouses_products � ���� value �����
-- ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, 
-- ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, 
-- ����� ��� ���������� � ������� ���������� �������� value. ������, ������� ������ ������ ���������� 
-- � �����, ����� ���� �������.

CREATE DATABASE task_3;

USE task_3;

DROP IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id INT UNSIGNED,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED
);

INSERT INTO storehouses_products VALUES
(1, 1, 1, 10),
(2, 1, 5, 20),
(3, 1, 7, 0),
(4, 2, 8, 4),
(5, 1, 10, 0);

ALTER TABLE storehouses_products ADD COLUMN for_sort INT UNSIGNED AFTER value;

UPDATE storehouses_products SET for_sort = 1 WHERE value = 0;
UPDATE storehouses_products SET for_sort = 2 WHERE value != 0;

SELECT * FROM storehouses_products;

SELECT * FROM storehouses_products ORDER BY for_sort DESC, value;
 
 
