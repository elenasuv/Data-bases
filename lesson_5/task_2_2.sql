-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

CREATE DATABASE task_2_2;

USE task_2_2;

CREATE TABLE users (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
birthdate DATE,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO users (id, name, birthdate)
   VALUES
  (DEFAULT, 'Maria', '1980-08-04'),
  (DEFAULT, 'Alex', '1990-05-23'),
  (DEFAULT, 'Maxim', '1988-01-05'),
  (DEFAULT, 'Olga', '1998-05-11'),
  (DEFAULT, 'Elena', '2000-02-15');
 
 SELECT *, DAYOFWEEK(DATE_FORMAT(birthdate, '2020-%m-%d')) AS day,
 DAYNAME(DATE_FORMAT(birthdate, '2020-%m-%d')) AS dayname 
 FROM users;

SELECT * FROM users;

SELECT COUNT(*), 
DAYNAME(DATE_FORMAT(birthdate, '2020-%m-%d')) AS dayname
FROM users GROUP BY dayname;

 
SELECT COUNT(*) DAYOFWEEK(DATE_FORMAT(birthdate, '2020-%m-%d')) AS day
FROM users GROUP BY 
DAYOFWEEK(DATE_FORMAT(birthdate, '2020-%m-%d')) AS day;