PRAGMA foreign_keys = ON;

CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
  -- question_id INTEGER NOT NULL,

  -- FOREIGN KEY(question_id) REFERENCES questions(id)
);


CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id)
);


CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body VARCHAR(255) NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  likes INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO
 users(fname,lname)
VALUES
('Billy','Bob')
  ;

INSERT INTO
 users(fname,lname)
VALUES
('James','Manson')
  ;

INSERT INTO
users(fname,lname)
VALUES
('Joey','Chaps')
;

INSERT INTO
  questions(title,body,user_id)
VALUES
  ('Help', 'I''m stuck under the bed', 1)
  ;

INSERT INTO
questions(title,body,user_id)
VALUES
('Advice needed', 'My hand is too big for the pringles jar, what do I do?', 2)
;

INSERT INTO
questions(title,body,user_id)
VALUES
('I''m curious', 'How many licks does it take to get to the center of a tootsie-pop?', 1)
;

INSERT INTO
  question_follows(question_id,user_id)
VALUES
  (1,1)
;


INSERT INTO
  question_follows(question_id,user_id)
VALUES
  (2,2)
;

INSERT INTO
  question_follows(question_id,user_id)
VALUES
  (3,1)
;

INSERT INTO
  replies(question_id,parent_reply_id,user_id, body)
VALUES
  (1,null,3, 'Have you tried getting out from under your bed?')
;

INSERT INTO
  replies(question_id,parent_reply_id,user_id, body)
VALUES
  (2,null,3, 'Throw away the jar! Those pringles are not accessible.')
;

INSERT INTO
  replies(question_id,parent_reply_id,user_id, body)
VALUES
  (3,null,3, '427093')
;

INSERT INTO
  question_likes(likes,question_id,user_id)
VALUES
  (1,1,3)
;

INSERT INTO
  question_likes(likes,question_id,user_id)
VALUES
  (1,2,3)
;

INSERT INTO
  question_likes(likes,question_id,user_id)
VALUES
  (0,3,3)
;
