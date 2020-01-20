-- ������ ��
CREATE DATABASE vk;

-- ������ � �������
USE vk;

-- ������ ������� �������������
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(15) NOT NULL UNIQUE,
  `password` VARCHAR(15),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ������� ��������
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL,
  birthdate DATE,
  sex CHAR(1) NOT NULL,
  hometown VARCHAR(100),
  country VARCHAR(100),
  photo_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ������� ���������
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  is_important BOOLEAN,
  is_delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);

-- ������� ������
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  status_id INT UNSIGNED NOT NULL,
  requested_at DATETIME DEFAULT NOW(),
  confirmed_at DATETIME,
  PRIMARY KEY (user_id, friend_id)
);

-- ������� �������� ��������� ���������
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);


-- ������� �����
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);

-- ������� ����� ������������� � �����
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (community_id, user_id)
);

-- ������� �����������
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  media_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ������� ����� �����������
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

-- ������� �������� ������� media_types
INSERT INTO media_types VALUES 
(DEFAULT, 'photo'),
(DEFAULT, 'video'),
(DEFAULT, 'audio'),
(DEFAULT, 'game'),
(DEFAULT, 'doc');

-- ��������� ������� ��������������� �������
SELECT * FROM users;

-- ��������� ������� ��������� ���������
CREATE TABLE family_statuses (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (50) NOT NULL UNIQUE
);

-- ��������� � ������� name ��������
INSERT INTO family_statuses (name)
  VALUES
  ('Single'),
  ('Married')
 ;
-- ��������� ��������� ������� profiles
DESC profiles;

-- ��������� ������� family_status_id � ������� profiles
ALTER TABLE profiles ADD COLUMN family_status_id INT UNSIGNED AFTER hometown;
 
-- ��������� ���� ������� family_status_id ���������� ������� �� 1 �� 2
UPDATE profiles SET family_status_id = FLOOR(1 + (RAND() * 2));

-- ��������� ������� profiles
SELECT * FROM profiles LIMIT 10;

-- ������� ��������� ������� users
DESC users;

-- ������������ ������� created_at � updated_at, ����� ���������� �� ����������� ������, ��� ��������
UPDATE users SET updated_at = created_at WHERE updated_at < created_at;

-- ������� ��������� ������� profiles
DESC profiles;

-- ������������ ������� created_at � updated_at, ����� ���������� �� ����������� ������, ��� ��������
UPDATE profiles SET updated_at = created_at WHERE updated_at < created_at;

-- ������������ ������� birthdate, ����� �������� �� ����������� ������, ��� ���� ��������
UPDATE profiles SET birthdate = created_at WHERE birthdate > created_at;

-- ������� ������� user_id �� ������� profiles
ALTER TABLE profiles DROP COLUMN user_id;

-- ��������� ������� user_id 
ALTER TABLE profiles ADD COLUMN user_id INT UNSIGNED NOT NULL FIRST;

-- ��������� ������� user_id ������ ���������� �����. ��� �� ������� ��� �������, ��� ��� ������� ���������� ������
ALTER TABLE profiles ADD PRIMARY KEY(user_id);

-- ��������� ������� profiles � ��������� ������� user_id ������� �� 1 �� 100. �� ����� ������� �� �� ��������� ���������� �����.
UPDATE profiles SET user_id = FLOOR(1 + (RAND() * 100));

-- ������� ������� user_id �� ������� profiles
ALTER TABLE profiles DROP COLUMN user_id;

-- ��������� ������� user_id � ���������� auto_increment � primary key 
ALTER TABLE profiles ADD COLUMN user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL FIRST;

-- ��������� �� �������� auto_increment, ��� ��� ����� � user_id ������������� ������ ���� �� �������. user_id ������ � id ������� users
  ALTER TABLE profiles MODIFY COLUMN user_id INT UNSIGNED UNIQUE;
 
 -- �������� ������� ������
 CREATE TABLE posts (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   author_id INT UNSIGNED NOT NULL,
   body TEXT NOT NULL,
   media_id INT UNSIGNED NOT NULL,
   created_at DATETIME DEFAULT NOW()
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
 );

-- ������ ������� ������
DROP TABLE posts;

-- �������� ������� ������
 CREATE TABLE posts (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   author_id INT UNSIGNED NOT NULL,
   body TEXT NOT NULL,
   media_id INT UNSIGNED NOT NULL,
   created_at DATETIME DEFAULT NOW(),
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
  );
 
 -- ��������� ������� � ������� communities
ALTER TABLE communities ADD COLUMN web VARCHAR(300) NOT NULL AFTER name;
ALTER TABLE communities ADD COLUMN created_at DATETIME DEFAULT NOW() AFTER web;
ALTER TABLE communities ADD COLUMN updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() AFTER created_at;

-- ������������ ������� created_at � updated_at, ����� ���������� �� ����������� ������, ��� ��������
UPDATE communities SET updated_at = created_at WHERE updated_at < created_at;

-- ��������� ������ ������� users
SELECT * FROM users LIMIT 10;


-- ��������� ������ ������� profiles
SELECT * FROM profiles LIMIT 10;

-- ��������� ������ ������� messages
SELECT * FROM messages LIMIT 10;

-- ���������� ���������� ���������� �������� to_user_id � from_user_id
UPDATE messages SET to_user_id = to_user_id + 1 WHERE from_user_id = to_user_id;

-- ��������� ������ ������� media
SELECT * FROM media LIMIT 10;

-- ������������ ������� created_at � updated_at, ����� ���������� �� ����������� ������, ��� ��������
UPDATE media SET updated_at = created_at WHERE updated_at < created_at;

-- �������� ������� user_id ���������� ����������
UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));

-- ������� �������� ������� filename
UPDATE media SET filename = CONCAT('http://dropbox/vk/file_', metadata);

-- �������� �������� ������� metadata
UPDATE media SET metadata = CONCAT(
  '{"',
  'owner',
  '":"',
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');
 
 -- ��������� ������ ������� friendship
SELECT * FROM friendship LIMIT 10;

-- �������� ������� user_id ���������� ����������
UPDATE friendship SET user_id = FLOOR(1 + (RAND() * 100));

-- ���������� ���������� ���������� �������� user_id � friend_id
UPDATE friendship SET user_id = user_id + 1 WHERE user_id = friend_id;

-- ������������ ������� created_at � updated_at, ����� ���������� �� ����������� ������, ��� ��������
UPDATE friendship SET requested_at = confirmed_at WHERE confirmed_at < requested_at;

-- ��������� ������ ������� friendship_statuses
SELECT * FROM friendship_statuses LIMIT 10;

-- ������ �������� ������� friendship_statuses
TRUNCATE friendship_statuses;

-- ��������� � ������� name ��������
INSERT INTO friendship_statuses (name)
  VALUES
  ('Confirmed'),
  ('Rejected'),
  ('Requested')
 ;

-- �������� ������� status_id ���������� ����������
UPDATE friendship SET status_id = FLOOR(1 + (RAND() * 3));

-- ������� ��������� ������� media
DESC media;

-- ������� ��� ������� metadata
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- ��������� ������ ������� communities
SELECT * FROM communities LIMIT 10;

-- ��������� ���������� communities �� 10
DELETE FROM communities WHERE id > 10;

-- ��������� ������ ������� communities_users
SELECT * FROM communities_users;

-- �������� ������� community_id ���������� ����������
UPDATE communities_users SET 
  community_id = FLOOR(1 + (RAND() * 10))
 ;

-- ��������� ������� family_statuses
SELECT * FROM family_statuses;

-- ��������� ������� posts
SELECT * FROM posts;
-- ������������ ������� created_at � updated_at, ����� ���������� �� ����������� ������, ��� ��������
UPDATE posts SET updated_at = created_at WHERE updated_at < created_at;

-- ������� ������� ������ �����
CREATE TABLE likes_media (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id INT UNSIGNED NOT NULL,
media_id INT UNSIGNED,
created_at DATETIME DEFAULT NOW()
);

-- ������� ������� ������ ������
CREATE TABLE likes_posts (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id INT UNSIGNED NOT NULL,
post_id INT UNSIGNED,
created_at DATETIME DEFAULT NOW()
);

-- ������� ������� ������ ���������
CREATE TABLE likes_communities (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id INT UNSIGNED NOT NULL,
community_id INT UNSIGNED,
created_at DATETIME DEFAULT NOW()
);

-- ��������� ������� ������ �����
SELECT * FROM likes_media;

-- ��������� ������� ������ ������
SELECT * FROM likes_posts;

-- ��������� ������� ������ ���������
SELECT * FROM likes_communities;







 





 
 

 





 