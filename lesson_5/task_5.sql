-- 5.(�� �������) �� ������� catalogs ����������� ������ ��� ������ �������.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN.

CREATE DATABASE task_5;

USE task_5;

CREATE TABLE catalogs (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

INSERT INTO catalogs
VALUES
(DEFAULT, '����������'),
(DEFAULT, '����������� �����'),
(DEFAULT, '����������'),
(DEFAULT, '������� �����'),
(DEFAULT, '����������� ������');

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD (id, 5, 1, 2);