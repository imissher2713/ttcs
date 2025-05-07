CREATE DATABASE IF NOT EXISTS toeic_app;
USE toeic_app;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE,
  password VARCHAR(255)
);

CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE lessons (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  description TEXT,
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE questions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  description TEXT,
  image VARCHAR(255),
  url VARCHAR(255),
  lesson_id INT,
  optionA TEXT,
  optionB TEXT,
  optionC TEXT,
  optionD TEXT,
  correctAnswer CHAR(1),
  point INT,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id)
);

CREATE TABLE question_history (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  lesson_id INT,
  question_id INT,
  point INT,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (lesson_id) REFERENCES lessons(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);