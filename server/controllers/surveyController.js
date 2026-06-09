import pool from '../config/db.js';

// FIRST QUESTION
export const getFirstQuestion = async (req, res) => {
  try {
    const userId = req.query.userId;
    let sequenceNo = 1;
    if (userId && userId !== 'undefined' && userId !== 'null') {
      sequenceNo = 3; // Skip name and department for registered users
    }
    const result = await pool.query(
      `SELECT * FROM survey_questions WHERE sequence_no = $1 LIMIT 1`,
      [sequenceNo]
    );

    if (result.rows.length === 0) {
      return res.json({ message: 'No questions found' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error getting first question:', error);
    res.status(500).json({ message: 'Server Error' });
  }
};

// NEXT QUESTION
export const getNextQuestion = async (req, res) => {
  try {
    const { sessionId, currentQuestionId, answer, questionCount, userId } = req.body;

    // MAX 10 QUESTIONS
    if (questionCount >= 10) {
      return res.json({ completed: true, message: '🎉 Survey Completed! Your responses have been saved.' });
    }

    // GET CURRENT QUESTION
    const currentQuestion = await pool.query(
      `SELECT * FROM survey_questions WHERE id = $1`,
      [currentQuestionId]
    );

    if (currentQuestion.rows.length === 0) {
      return res.json({ completed: true, message: 'Question not found' });
    }

    const question = currentQuestion.rows[0];

    // SAVE RESPONSE (with optional user_id)
    await pool.query(
      `INSERT INTO survey_responses (session_id, user_id, question_id, question, answer)
       VALUES ($1, $2, $3, $4, $5)`,
      [sessionId, userId || null, question.id, question.question, answer]
    );

    let nextQuestion;
    const cleanAnswer = answer.toLowerCase().trim();

    // 1. Try to find a trigger match for the answer
    nextQuestion = await pool.query(
      `SELECT * FROM survey_questions WHERE trigger_value = $1 ORDER BY sequence_no ASC LIMIT 1`,
      [cleanAnswer]
    );

    // 2. If no trigger match, stay in current category
    if (nextQuestion.rows.length === 0) {
      nextQuestion = await pool.query(
        `SELECT * FROM survey_questions
         WHERE category = $1 AND sequence_no > $2
         ORDER BY sequence_no ASC LIMIT 1`,
        [question.category, question.sequence_no]
      );
    }

    // 3. If current category exhausted, fallback to next unanswered general question
    if (nextQuestion.rows.length === 0) {
      nextQuestion = await pool.query(
        `SELECT * FROM survey_questions
         WHERE category = 'general' 
         AND id NOT IN (SELECT question_id FROM survey_responses WHERE session_id = $1)
         ORDER BY sequence_no ASC LIMIT 1`,
        [sessionId]
      );
    }

    // SURVEY COMPLETE
    if (nextQuestion.rows.length === 0) {
      return res.json({ completed: true, message: '🎉 Survey Completed! Your responses have been saved.' });
    }

    // SEND NEXT QUESTION
    res.json(nextQuestion.rows[0]);
  } catch (error) {
    console.error('Error getting next question:', error);
    res.status(500).json({ message: 'Server Error' });
  }
};