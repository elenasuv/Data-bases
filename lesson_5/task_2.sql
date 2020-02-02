-- 2. ������� users ���� �������� ��������������. 
-- ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � �������
--  "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
CREATE DATABASE task_2;

USE task_2;

CREATE TABLE users (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
created_at VARCHAR(100) NOT NULL,
updated_at VARCHAR(100) NOT NULL
);

INSERT INTO users VALUES
(DEFAULT, 'Elena', '20.10.2017 8:10', '23.10.2017 23:15'),
(DEFAULT, 'Maxim', '22.11.2018 15:30', '26.11.2018 23:15');

SELECT * FROM users;

UPDATE users SET 
  created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i')
  ; 

UPDATE users SET 
  updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i')
  ;
 
ALTER TABLE users MODIFY COLUMN created_at DATETIME;

ALTER TABLE users MODIFY COLUMN updated_at DATETIME;

DESC users;

 