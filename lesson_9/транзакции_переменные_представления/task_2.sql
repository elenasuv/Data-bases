-- Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.

SELECT * FROM products;
SELECT * FROM catalogs;

CREATE VIEW tabl (name, catalog)
 AS SELECT name,
  (SELECT name FROM catalogs WHERE id = catalog_id)
FROM products;

SELECT * FROM tabl;
