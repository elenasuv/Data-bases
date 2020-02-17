-- (по желанию) Подсчитайте произведение чисел в столбце таблицы

CREATE DATABASE task_3_2;

USE task_3_2;

CREATE TABLE task (
value INT);

INSERT INTO task VALUES
(1),
(2),
(3),
(4),
(5);

SELECT EXP(SUM(LN(value))) AS result FROM task;