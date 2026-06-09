import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import pool from './config/db.js';
import authRoutes from './routes/authRoutes.js';
import surveyRoutes from './routes/surveyRoutes.js';
import reportRoutes from './routes/reportRoutes.js';

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/survey', surveyRoutes);
app.use('/api/reports', reportRoutes);

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Initialize database tables
const initDB = async () => {
  try {
    // Create users table
    await pool.query(`
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        full_name VARCHAR(100) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        password_hash VARCHAR(255) NOT NULL,
        department VARCHAR(100),
        role VARCHAR(20) DEFAULT 'student',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);

    // Ensure role column exists if upgrading from an older DB schema
    try {
      await pool.query(`ALTER TABLE users ADD COLUMN role VARCHAR(20) DEFAULT 'student'`);
      console.log('✅ Added role column to users table');
    } catch (err) {
      // Column already exists, ignore
    }

    // Create survey_questions table
    await pool.query(`
      CREATE TABLE IF NOT EXISTS survey_questions (
        id SERIAL PRIMARY KEY,
        sequence_no INT NOT NULL UNIQUE,
        question TEXT NOT NULL,
        question_type VARCHAR(50),
        options JSONB,
        category VARCHAR(50) DEFAULT 'general',
        trigger_value VARCHAR(100),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);

    // Create survey_responses table
    await pool.query(`
      CREATE TABLE IF NOT EXISTS survey_responses (
        id SERIAL PRIMARY KEY,
        session_id UUID NOT NULL,
        user_id INTEGER REFERENCES users(id),
        question_id INT NOT NULL,
        question TEXT,
        answer TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);

    // Create indexes
    await pool.query('CREATE INDEX IF NOT EXISTS idx_session_id ON survey_responses(session_id)');
    await pool.query('CREATE INDEX IF NOT EXISTS idx_responses_user_id ON survey_responses(user_id)');

    console.log('✅ Database tables initialized');
  } catch (error) {
    console.error('❌ Database init error:', error.message);
  }
};

const PORT = process.env.PORT || 5000;

app.listen(PORT, async () => {
  console.log(`🚀 Server running on port ${PORT}`);
  await initDB();
});