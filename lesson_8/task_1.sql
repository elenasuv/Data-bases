DESC friendship;
 
 -- Добавляем внешние ключи для таблицы friendship
ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_status_id_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);
   
   DESC communities_users;
  
  -- Добавляем внешние ключи для таблицы сomunities_users
ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
   
 DESC media;
-- Добавляем внешние ключи для таблицы media
ALTER TABLE media
  ADD CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id),
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
   
  SHOW TABLES;
 
 DESC communities;
 DESC family_statuses;
 DESC friendship_statuses;
 DESC likes; 

-- Добавляем внешние ключи для таблицы likes
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id);
   
 DESC posts;

-- Добавляем внешние ключи для таблицы posts
ALTER TABLE posts
  ADD CONSTRAINT posts_author_id_fk 
    FOREIGN KEY (author_id) REFERENCES users(id),
  ADD CONSTRAINT posts_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id);

DESC profiles;

-- Добавляем недостающие внешние ключи для таблицы profiles
ALTER TABLE profiles
  ADD CONSTRAINT profiles_family_status_id_fk 
    FOREIGN KEY (family_status_id) REFERENCES family_statuses(id);
   