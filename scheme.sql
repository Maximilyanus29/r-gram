--возможно отдельный сервис мессенджер Юзерсы
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    email varchar(255) NOT NULL,
    "login" varchar(255) NOT NULL,
    "password" varchar(255) NOT NULL,
    salt varchar(255) NOT NULL,
    first_name varchar(255) NULL,
    last_name varchar(255) NULL,
    sur_name varchar(255) NULL,
    image_media_id bigint NULL,-- для произовдительности не буду пихать сюда аватар пользователя.
);

INSERT INTO Users (email, login, password, salt) VALUES ('admin@admin.admin', 'admin', 'admin', '');
INSERT INTO Users (email, login, password, salt) VALUES ('test1@test1.test1', 'test1', 'test1', '');
INSERT INTO Users (email, login, password, salt) VALUES ('test2@test2.test2', 'test2', 'test2', '');
INSERT INTO Users (email, login, password, salt) VALUES ('test3@test3.test3', 'test3', 'test3', '');
INSERT INTO Users (email, login, password, salt) VALUES ('test4@test4.test4', 'test4', 'test4', '');
INSERT INTO Users (email, login, password, salt) VALUES ('test5@test5.test5', 'test5', 'test5', '');


CREATE TABLE Subscribers (--сделать партицирование
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    user_id_first integer NOT NULL,
    user_id_last integer NOT NULL
);
--возможно отдельный сервис мессенджер ЭНД
INSERT INTO Subscribers (user_id_first, user_id_last) VALUES (1, 2);
INSERT INTO Subscribers (user_id_first, user_id_last) VALUES (1, 5);
INSERT INTO Subscribers (user_id_first, user_id_last) VALUES (2, 1);

--возможно отдельный сервис мессенджер посты
CREATE TABLE Posts (--сделать партицирование
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    user_id integer NOT NULL,
    "type" smallint NOT NULL,--image(1),video(2),history(3),shorts(4),group(5)
    "description" text NULL,
    likes integer NOT NULL,
);

INSERT INTO Posts (user_id, type, description, likes) VALUES (1, 1, '1', 1);
INSERT INTO Posts (user_id, type, description, likes) VALUES (1, 2, '1', 1);
INSERT INTO Posts (user_id, type, description, likes) VALUES (1, 3, '1', 1);
INSERT INTO Posts (user_id, type, description, likes) VALUES (1, 4, '1', 1);
INSERT INTO Posts (user_id, type, description, likes) VALUES (1, 5, '1', 1);


INSERT INTO Posts (user_id, type, description, likes) VALUES (2, 2, '2', 2);
INSERT INTO Posts (user_id, type, description, likes) VALUES (1, 1, '1', 1);
INSERT INTO Posts (user_id, type, description, likes) VALUES (1, 1, '1', 1);
INSERT INTO Posts (user_id, type, description, likes) VALUES (1, 1, '1', 1);



CREATE TABLE Likes (--сделать партицирование
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    post_id bigint NOT NULL,
    user_id_first integer NOT NULL,
    user_id_last integer NOT NULL
);

INSERT INTO Posts (post_id, user_id_first, user_id_last) VALUES (1, 2, 1);
INSERT INTO Posts (post_id, user_id_first, user_id_last) VALUES (1, 3, 1);
INSERT INTO Posts (post_id, user_id_first, user_id_last) VALUES (1, 4, 1);
INSERT INTO Posts (post_id, user_id_first, user_id_last) VALUES (1, 5, 1);


CREATE TABLE Comments (--сделать партицирование
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    post_id bigint NOT NULL,
    user_id integer NOT NULL,
    "text" text NOT NULL,
);
--возможно отдельный сервис мессенджер посты ЭНД
INSERT INTO Comments (post_id, user_id, text) VALUES (1, 2, '1');
INSERT INTO Comments (post_id, user_id, text) VALUES (1, 3, '3');
INSERT INTO Comments (post_id, user_id, text) VALUES (1, 4, '4');


--возможно отдельый сервис типа как хранилище, точно можно кидать src от бэка а потом фронт сам будет обращатся в хранилище за медиа данными.
CREATE TABLE Media (--сделать партицирование
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    "type" smallint NOT NULL,--image(1),video(2),history(3),shorts(4)
    src int NOT NULL,--src реально можно сделать интом, что бы много места не занимало. Просто автоинкрементим по юзеру, возможно надо будет захэшировать
    user_id integer NOT NULL,
    post_id integer NOT NULL-- для произовдительности не буду пихать сюда аватар пользователя.
);
--возможно отдельый сервис КОнец 
INSERT INTO Media (type, src, user_id, post_id) VALUES (1, '1', 1, 1);










--возможно отдельный сервис мессенджер
CREATE TABLE Messages (--сделать партицирование
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    reply_message_id bigint NULL,
    attachment smallint NULL,--{photos:[{}, {}], videos:[{}], documents, gif, sticker, post}
    "text" text NULL,
    user_id_from integer NOT NULL,
    user_id_to integer NOT NULL,
);

INSERT INTO Messages (text, user_id_from, user_id_to) VALUES ('1', 1, 2);



CREATE TABLE MesagesMedia (--возможно медиа сделать для сообщений отдельно, типа отдельный сервис будет.
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    "type" smallint NOT NULL,--image(1),video(2),history(3),shorts(4),group(5)
    src int NOT NULL,--src реально можно сделать интом, что бы много места не занимало. Просто автоинкрементим по юзеру, возможно надо будет захэшировать
    user_id integer NOT NULL,
    post_id integer NOT NULL-- для произовдительности не буду пихать сюда аватар пользователя.
);
INSERT INTO MesagesMedia (type) VALUES (1, '1', 1, 1);

--возможно отдельый сервис КОнец 





-- CREATE TABLE Stories (
--     id SERIAL PRIMARY KEY,
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
--     updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
--     user_id integer NOT NULL,
--     media_id bigint NOT NULL
-- )

-- CREATE TABLE StoriesGroup (
--     id SERIAL PRIMARY KEY,
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
--     updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
--     user_id integer NOT NULL,

-- --
-- )


-- CREATE TABLE Reels (
--     id SERIAL PRIMARY KEY,
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
--     updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
--     user_id integer NOT NULL,
--     "description" text NULL,
--     media_id bigint NOT NULL
-- )