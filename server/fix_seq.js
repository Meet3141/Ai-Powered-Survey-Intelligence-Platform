import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import pg from 'pg';
import dotenv from 'dotenv';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config({ path: path.join(__dirname, '.env') });

const { Pool } = pg;

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME
});

async function fixSequence() {
  try {
    // Check current max ID
    const res = await pool.query('SELECT MAX(id) as max_id FROM users');
    const maxId = res.rows[0].max_id || 0;
    
    // Set sequence to maxId + 1
    console.log(`Setting users sequence to ${maxId + 1}`);
    await pool.query(`SELECT setval('users_id_seq', ${maxId + 1}, false)`);
    
    console.log('✅ Sequence fixed successfully!');
  } catch (error) {
    console.error('❌ Error executing SQL:', error);
  } finally {
    await pool.end();
  }
}

fixSequence();
