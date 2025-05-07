const express = require('express');
const router = express.Router();
const { getQuizzes, getQuizQuestions, submitQuiz } = require('../controllers/quizController');

router.get('/', getQuizzes);
router.get('/:quizId/questions', getQuizQuestions);
router.post('/submit', submitQuiz);
module.exports = router;