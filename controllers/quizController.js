const db = require('../models/db');

exports.getQuizzes = async (req, res) => {
  const [quizzes] = await db.query('SELECT * FROM quizzes');
  res.json(quizzes);
};

exports.getQuizQuestions = async (req, res) => {
  const { quizId } = req.params;
  const [questions] = await db.query('SELECT id, question_text, option_a, option_b, option_c, option_d FROM questions WHERE quiz_id = ?', [quizId]);
  res.json(questions);
};

exports.submitQuiz = async (req, res) => {
  const { quizId, answers } = req.body;
  const [questions] = await db.query('SELECT id, correct_option FROM questions WHERE quiz_id = ?', [quizId]);

  let score = 0;
  questions.forEach((q) => {
    if (answers[q.id] === q.correct_option) score += 1;
  });

  await db.query('INSERT INTO results (user_id, quiz_id, score) VALUES (?, ?, ?)', [req.user.id, quizId, score]);
  res.json({ score });
};