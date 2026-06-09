import express from 'express';
import { signUp, signIn, getMe } from '../controllers/authController.js';
import authMiddleware from '../middleware/authMiddleware.js';

const router = express.Router();

router.post('/signup', signUp);
router.post('/signin', signIn);
router.get('/me', authMiddleware, getMe);

export default router;
