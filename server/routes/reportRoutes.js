import express from 'express';
import axios from 'axios';
import path from 'path';
import { fileURLToPath } from 'url';
import authMiddleware from '../middleware/authMiddleware.js';
import adminMiddleware from '../middleware/adminMiddleware.js';
import pool from '../config/db.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const router = express.Router();

// POST /api/reports/generate — Run full pipeline (Admin only)
router.post('/generate', adminMiddleware, async (req, res) => {
  try {
    console.log('🚀 Starting full agent pipeline...');

    const agent2Url = process.env.AGENT2_URL;
    const agent3Url = process.env.AGENT3_URL;

    if (!agent2Url || !agent3Url) {
      throw new Error('AGENT2_URL and AGENT3_URL environment variables must be configured.');
    }

    // Step 1: Run cleaning agent (Agent 2)
    console.log(`🧹 Running cleaning agent via ${agent2Url}/clean...`);
    const cleanResponse = await axios.post(`${agent2Url}/clean`);
    console.log('✅ Cleaning complete:', cleanResponse.data);

    // Step 2: Run clustering agent (Agent 3)
    console.log(`🤖 Running clustering agent via ${agent3Url}/pipeline/run...`);
    const clusterResponse = await axios.post(`${agent3Url}/pipeline/run`);
    console.log('✅ Clustering complete:', clusterResponse.data);

    console.log('📊 Pipeline generation complete');

    res.json({
      status: 'success',
      message: 'Report generation pipeline executed successfully',
      agent2_results: cleanResponse.data,
      agent3_results: clusterResponse.data
    });
  } catch (error) {
    console.error('Pipeline error:', error.response?.data || error.message);
    res.status(500).json({ status: 'error', message: error.response?.data?.detail || error.message });
  }
});

// GET /api/reports/stats — Get dashboard statistics
// All metrics read from the SAME validated source: survey_responses table.
// This ensures Report totals == Dashboard totals regardless of how data was seeded.
router.get('/stats', adminMiddleware, async (req, res) => {
  try {
    // ── CORE METRICS (single source of truth: survey_responses) ─────────

    // Survey Participants: unique users who submitted at least one response.
    // Uses user_id when present; falls back to counting distinct sessions
    // for any anonymous/seeded rows where user_id is NULL.
    const participantsResult = await pool.query(`
      SELECT
        COUNT(DISTINCT user_id)::int          AS linked_users,
        COUNT(DISTINCT session_id)::int        AS total_sessions,
        COUNT(*)::int                          AS total_answers
      FROM survey_responses
    `);
    const { linked_users, total_sessions, total_answers } = participantsResult.rows[0];

    // Registered Students: count linked users first; if none are linked
    // (seeded data without user records), fall back to session count.
    const totalUsers     = linked_users > 0 ? linked_users : total_sessions;
    const totalSessions  = total_sessions;
    const totalAnswers   = total_answers;

    // ── DISTRIBUTION QUERIES ─────────────────────────────────────────────

    // Department distribution
    const deptResult = await pool.query(`
      SELECT sr.answer AS label, COUNT(*) AS count
      FROM survey_responses sr
      JOIN survey_questions sq ON sr.question_id = sq.id
      WHERE LOWER(sq.question) LIKE '%department%'
        AND sr.answer IS NOT NULL
        AND TRIM(sr.answer) <> ''
      GROUP BY sr.answer
      ORDER BY count DESC
      LIMIT 10
    `);

    // Interest distribution
    const interestResult = await pool.query(`
      SELECT sr.answer AS label, COUNT(*) AS count
      FROM survey_responses sr
      JOIN survey_questions sq ON sr.question_id = sq.id
      WHERE LOWER(sq.question) LIKE '%interest%'
        AND sr.answer IS NOT NULL
        AND TRIM(sr.answer) <> ''
      GROUP BY sr.answer
      ORDER BY count DESC
      LIMIT 10
    `);

    // Career goals
    const careerResult = await pool.query(`
      SELECT sr.answer AS label, COUNT(*) AS count
      FROM survey_responses sr
      JOIN survey_questions sq ON sr.question_id = sq.id
      WHERE (LOWER(sq.question) LIKE '%goal%' OR LOWER(sq.question) LIKE '%career%')
        AND sr.answer IS NOT NULL
        AND TRIM(sr.answer) <> ''
      GROUP BY sr.answer
      ORDER BY count DESC
      LIMIT 10
    `);

    // Skills / Technology
    const skillResult = await pool.query(`
      SELECT sr.answer AS label, COUNT(*) AS count
      FROM survey_responses sr
      JOIN survey_questions sq ON sr.question_id = sq.id
      WHERE (LOWER(sq.question) LIKE '%skill%' OR LOWER(sq.question) LIKE '%technology%')
        AND sr.answer IS NOT NULL
        AND TRIM(sr.answer) <> ''
      GROUP BY sr.answer
      ORDER BY count DESC
      LIMIT 10
    `);

    // Teamwork preferences
    const teamworkResult = await pool.query(`
      SELECT sr.answer AS label, COUNT(*) AS count
      FROM survey_responses sr
      JOIN survey_questions sq ON sr.question_id = sq.id
      WHERE LOWER(sq.question) LIKE '%team%'
        AND sr.answer IS NOT NULL
        AND TRIM(sr.answer) <> ''
      GROUP BY sr.answer
      ORDER BY count DESC
      LIMIT 10
    `);

    // Recent responses (last 20)
    const recentResult = await pool.query(`
      SELECT session_id, question, answer, created_at
      FROM survey_responses
      ORDER BY created_at DESC
      LIMIT 20
    `);

    res.json({
      // ── Core stats — all from survey_responses (single source) ──
      totalUsers,      // survey participants (user_id linked or session fallback)
      totalSessions,   // completed survey sessions
      totalAnswers,    // total data points collected

      // ── Distributions ──
      departments:     deptResult.rows,
      interests:       interestResult.rows,
      careerGoals:     careerResult.rows,
      skills:          skillResult.rows,
      teamwork:        teamworkResult.rows,
      recentResponses: recentResult.rows,
    });
  } catch (error) {
    console.error('Stats error:', error);
    res.status(500).json({ message: 'Failed to fetch statistics' });
  }
});

// Serve the specific cleaned_data.xlsx from Agent 3 inputs as requested
router.get('/download/cleaned_data.xlsx', adminMiddleware, (req, res) => {
  const filePath = path.join(__dirname, '../../agents/cleaning/agent3-community-intelligence/inputs/cleaned_data.xlsx');
  res.download(filePath, 'cleaned_data.xlsx');
});

// Serve generated PDFs and files securely to admins
router.use('/download', adminMiddleware, express.static(path.join(__dirname, '../../agents/outputs')));

export default router;
