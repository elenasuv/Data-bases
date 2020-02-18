-- Создаем индекс на столбец email
CREATE INDEX users_email_idx ON users(email);

SELECT email FROM users ORDER BY email;

-- Создаем индекс на столбец birthdate
CREATE INDEX profiles_birthdate_idx ON profiles(birthdate);

-- Удалим индекс на столбец email и создадим вновь, сделав его уникальным
DROP INDEX users_email_idx ON users;
CREATE UNIQUE INDEX users_email_uq ON users(email);

-- Создаем индекс на столбец size
CREATE INDEX media_size_idx ON media(size);

-- Создадим составной индекс sex и birthdate
CREATE INDEX profiles_sex_profiles_birthdate_idx ON profiles(sex, birthdate);

-- Создаем индекс на столбец last_name
CREATE INDEX users_last_name_idx ON users(last_name);

-- Создаем индекс на столбец hometown
CREATE INDEX profiles_hometown_idx ON profiles(hometown);

-- Создаем индекс на столбец country
CREATE INDEX profiles_country_idx ON profiles(country);
