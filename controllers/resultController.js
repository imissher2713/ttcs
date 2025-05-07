const db = require('../models/db');

exports.getAllResults = async (req, res) => {
  if (req.user.role !== 'teacher') return res.status(403).json({ message: 'Access denied' });

  const [results] = await db.query(`
    SELECT users.username, quizzes.title, results.score, results.created_at
    FROM results
    JOIN users ON results.user_id = users.id
    JOIN quizzes ON results.quiz_id = quizzes.id
  `);
  res.json(results);
};