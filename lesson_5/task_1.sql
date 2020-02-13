-- 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. 
-- ��������� �� �������� ����� � ��������.
CREATE DATABASE lesson_5;

USE lesson_5;

CREATE TABLE users (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
created_at DATETIME,
updated_at DATETIME
);

INSERT INTO users (id, name) VALUES
(DEFAULT, 'Elena'),
(DEFAULT, 'Maxim');

SELECT * FROM users;

TRUNCATE users;

INSERT INTO users VALUES
(DEFAULT, 'Elena', NOW(), NOW()),
(DEFAULT, 'Maxim', NOW(), NOW());


 