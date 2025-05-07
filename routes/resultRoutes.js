const express = require('express');
const router = express.Router();
const { getAllResults } = require('../controllers/resultController');

router.get('/', getAllResults);
module.exports = router;