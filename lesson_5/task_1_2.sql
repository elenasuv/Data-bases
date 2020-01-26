-- Подсчитайте средний возраст пользователей в таблице users

CREATE DATABASE task_1_2;

USE task_1_2;

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
 
 SELECT *FROM users;

 ALTER TABLE users ADD COLUMN age INT NOT NULL AFTER birthdate;

UPDATE users SET age = (TO_DAYS(NOW()) - TO_DAYS(birthdate))/365.25;

SELECT AVG(age) AS average_age FROM users;





