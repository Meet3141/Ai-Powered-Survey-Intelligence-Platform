import pg from 'pg';
import dotenv from 'dotenv';
dotenv.config();

const { Pool } = pg;

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME
});

const questions = [
  { sequence: 1, question: "What's your name?", type: "open_ended", options: null, category: "general", trigger: null },
  { sequence: 2, question: "What is your department?", type: "single_choice", options: JSON.stringify(["Computer Science", "Information Technology", "Electronics", "Mechanical"]), category: "general", trigger: null },
  { sequence: 3, question: "What are your main areas of interest?", type: "multiple_choice", options: JSON.stringify(["Web Development", "AI/ML", "Cybersecurity", "Data Science", "Cloud Computing"]), category: "general", trigger: null },
  { sequence: 4, question: "How would you rate your current skill level in programming?", type: "rating", options: null, category: "general", trigger: null },
  { sequence: 5, question: "What are your primary career goals?", type: "multiple_choice", options: JSON.stringify(["Software Engineer", "Data Scientist", "Product Manager", "Researcher", "Entrepreneur"]), category: "general", trigger: null },
  { sequence: 6, question: "Which technologies do you want to learn next?", type: "multiple_choice", options: JSON.stringify(["React", "Python", "Node.js", "Docker", "AWS", "TensorFlow"]), category: "general", trigger: null },
  { sequence: 7, question: "Do you prefer working individually or in a team?", type: "single_choice", options: JSON.stringify(["Individually", "In a team", "Depends on the project"]), category: "general", trigger: null },
  { sequence: 8, question: "What kind of projects excite you the most?", type: "open_ended", options: null, category: "general", trigger: null },
  { sequence: 9, question: "How much time can you dedicate to community projects weekly?", type: "single_choice", options: JSON.stringify(["1-2 hours", "3-5 hours", "5-10 hours", "10+ hours"]), category: "general", trigger: null },
  { sequence: 10, question: "Any additional comments or expectations?", type: "open_ended", options: null, category: "general", trigger: null }
];

async function seed() {
  try {
    const res = await pool.query('SELECT COUNT(*) FROM survey_questions');
    if (parseInt(res.rows[0].count) === 0) {
      console.log('Seeding survey questions...');
      for (const q of questions) {
        await pool.query(
          `INSERT INTO survey_questions (sequence_no, question, question_type, options, category, trigger_value)
           VALUES ($1, $2, $3, $4, $5, $6)`,
          [q.sequence, q.question, q.type, q.options, q.category, q.trigger]
        );
      }
      console.log('Seeding complete!');
    } else {
      console.log('Questions already exist.');
    }
  } catch (err) {
    console.error('Seeding error:', err);
  } finally {
    pool.end();
  }
}

seed();
