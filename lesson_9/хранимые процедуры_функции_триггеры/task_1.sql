-- Создайте хранимую функцию hello(), которая будет возвращать приветствие,
-- в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер",
-- с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	 DECLARE time_of_day INT;
	 SET time_of_day = HOUR(CURRENT_TIMESTAMP);
	 CASE
	    WHEN time_of_day BETWEEN 6 AND 11 THEN
	      RETURN 'Доброе утро';
	    WHEN time_of_day BETWEEN 12 AND 17 THEN
	      RETURN 'Добрый день';
	    WHEN time_of_day BETWEEN 18 AND 23 THEN
	      RETURN 'Добрый вечер';
	    WHEN time_of_day BETWEEN 0 AND 5 THEN
	      RETURN 'Доброй ночи'; 
	    END CASE;
END//


SELECT hello()//
