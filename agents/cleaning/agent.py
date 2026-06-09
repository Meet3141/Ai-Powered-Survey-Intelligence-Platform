import os
import json
from pathlib import Path
from groq import Groq
from dotenv import load_dotenv
from utils.prompts import CLEANING_PROMPT

load_dotenv(dotenv_path=Path(__file__).resolve().parent / ".env", override=False)


def _default_cleaning_plan():
    return {
        "remove_duplicates": True,
        "fill_missing_numeric": "mean",
        "fill_missing_categorical": "mode",
        "trim_spaces": True,
        "standardize_text": True,
    }


def _get_groq_client():
    api_key = os.getenv("GROQ_API_KEY", "").strip()
    if not api_key:
        return None

    return Groq(api_key=api_key)


def ai_cleaning_agent(profile):

    client = _get_groq_client()
    if client is None:
        print("GROQ_API_KEY not set. Using default cleaning plan.")
        return _default_cleaning_plan()

    prompt = CLEANING_PROMPT + f"""

Dataset Profile:

{json.dumps(profile, indent=2)}

Generate cleaning steps.
Ensure the output is a valid JSON dictionary.

Example:
{{
    "remove_duplicates": true,
    "fill_missing_numeric": "mean",
    "fill_missing_categorical": "mode",
    "trim_spaces": true,
    "standardize_text": true
}}
"""

    try:
        response = client.chat.completions.create(
            model="llama-3.3-70b-versatile",
            messages=[
                {
                    "role": "user",
                    "content": prompt
                }
            ],
            temperature=0.1,
            response_format={"type": "json_object"},
            timeout=15.0  # Add explicit timeout
        )

        result = response.choices[0].message.content

        print("\n===== AI CLEANING PLAN =====\n")
        print(result)

        cleaning_plan = json.loads(result)
    except Exception as e:
        print(f"\n[WARNING] Failed to consult AI agent ({e}). Using default cleaning plan.")
        cleaning_plan = _default_cleaning_plan()

    return cleaning_plan