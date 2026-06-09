import os
from pathlib import Path
import psycopg2
import pandas as pd
from dotenv import load_dotenv
import urllib.parse
import warnings

load_dotenv(dotenv_path=Path(__file__).resolve().parents[2] / "server" / ".env", override=True)


def _load_fallback_dataset():
    """Load survey data from local files when PostgreSQL is unavailable."""
    base_dir = Path(__file__).resolve().parent
    candidate_paths = [
        base_dir / "uploads" / "survey_data.csv",
        base_dir / "uploads" / "survey_data1.csv",
        base_dir / "outputs" / "cleaned_dataset.xlsx",
        base_dir / "outputs" / "raw_dataset.xlsx",
        base_dir / "outputs" / "cleaned_data.xlsx",
        base_dir.parent / "agent3-community-intelligence" / "inputs" / "cleaned_data.xlsx",
    ]

    for path in candidate_paths:
        if not path.exists():
            continue

        if path.suffix.lower() == ".csv":
            df = pd.read_csv(path)
        else:
            df = pd.read_excel(path)

        if {"session_id", "question", "answer"}.issubset(df.columns):
            df = df.rename(
                columns={
                    "session_id": "user_id",
                    "answer": "clean_answer",
                }
            )

        print(f"Loaded fallback dataset from {path}")
        return df

    return None

def fetch_survey_data():
    """
    Fetches raw survey data from the PostgreSQL database.
    """
    try:
        # DB Configuration
        user = os.getenv("DB_USER", "postgres")
        password = os.getenv("DB_PASSWORD")
        host = os.getenv("DB_HOST", "127.0.0.1")
        port = os.getenv("DB_PORT", "5432")
        dbname = os.getenv("DB_NAME", "survey_ai")
        
        # URL encode password to handle special characters like '@'
        encoded_password = urllib.parse.quote_plus(password) if password else ""
        
        # Connection URI
        uri = f"postgresql://{user}:{encoded_password}@{host}:{port}/{dbname}?sslmode=disable"
        
        print(f"Attempting to connect to {dbname} on {host}:{port} as {user}...")
        
        conn = psycopg2.connect(uri)

        query = """
            SELECT 
                sr.session_id, 
                sr.user_id,
                sr.question, 
                sr.answer,
                u.full_name,
                u.department
            FROM survey_responses sr
            LEFT JOIN users u ON sr.user_id = u.id
        """

        print("Fetching data from PostgreSQL...")
        with warnings.catch_warnings():
            warnings.simplefilter('ignore', UserWarning)
            df = pd.read_sql(query, conn)

        # Build stable identifier (use postgres user.id if available, fallback to session_id)
        df['student_identifier'] = df['user_id'].fillna(df['session_id']).astype(str)
        
        # Extract registered users who have a full_name
        users_df = df[['student_identifier', 'full_name', 'department']].drop_duplicates().dropna(subset=['full_name'])
        
        # Synthesize answers for name and department so Agent 2 has them automatically
        name_rows = pd.DataFrame({
            'student_identifier': users_df['student_identifier'],
            'question': "What's your name?",
            'answer': users_df['full_name']
        })
        
        dept_rows = pd.DataFrame({
            'student_identifier': users_df['student_identifier'],
            'question': "What is your department?",
            'answer': users_df['department']
        })
        
        # Combine survey answers with the injected registration data
        final_df = pd.concat([
            df[['student_identifier', 'question', 'answer']], 
            name_rows, 
            dept_rows
        ], ignore_index=True)
        
        # Rename to match what Agent 2 expects
        final_df = final_df.rename(columns={
            'student_identifier': 'user_id',
            'answer': 'clean_answer'
        })
        
        # Keep the latest answer if there are duplicates
        final_df = final_df.drop_duplicates(subset=['user_id', 'question'], keep='last')

        conn.close()
        return final_df
        
    except Exception as e:
        print(f"Error fetching data: {e}")
        fallback_df = _load_fallback_dataset()
        if fallback_df is not None:
            return fallback_df

        return None
