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

async function runSeed() {
  try {
    const sqlPath = path.join(__dirname, '../seed_test_data.sql');
    const sql = fs.readFileSync(sqlPath, 'utf8');
    
    console.log('Connecting to database:', process.env.DB_NAME);
    console.log('Executing seed_test_data.sql...');
    
    await pool.query(sql);
    
    console.log('✅ Seed data successfully inserted into the database!');
  } catch (error) {
    console.error('❌ Error executing SQL:', error);
  } finally {
    await pool.end();
  }
}

runSeed();
