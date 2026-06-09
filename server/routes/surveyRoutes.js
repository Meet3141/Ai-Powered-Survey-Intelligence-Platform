import express from 'express';
import { getFirstQuestion, getNextQuestion } from '../controllers/surveyController.js';
import { optionalAuth } from '../middleware/authMiddleware.js';

const router = express.Router();

// Survey routes (optional auth - works with or without login)
router.get('/start', getFirstQuestion);
router.post('/next', optionalAuth, getNextQuestion);

export default router;