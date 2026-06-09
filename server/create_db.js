import pg from 'pg';
import dotenv from 'dotenv';
dotenv.config();

const { Pool } = pg;

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
  database: 'postgres' // Connect to default database first
});

async function createDb() {
  try {
    const res = await pool.query(`SELECT datname FROM pg_catalog.pg_database WHERE datname = 'survey_chatbot'`);
    if (res.rowCount === 0) {
      console.log('Creating database survey_chatbot...');
      await pool.query(`CREATE DATABASE survey_chatbot`);
      console.log('Database created!');
    } else {
      console.log('Database already exists.');
    }
  } catch (err) {
    console.error('Error creating db:', err);
  } finally {
    await pool.end();
  }
}

createDb();
