import os
from fastapi import FastAPI, HTTPException
from fastapi.responses import FileResponse
import pandas as pd
from pathlib import Path

from profiler import profile_dataset
from agent import ai_cleaning_agent
from cleaner import apply_cleaning, normalize_interest
from structure import structure_dataset
from validator import validate_dataset
from database import fetch_survey_data
from exporter import export_excel

app = FastAPI(title="Agent 2 Cleaning Service")

@app.get("/health")
def health_check():
    return {"status": "ok"}

@app.post("/clean")
def run_clean_pipeline():
    print("--- Starting SurveyClean AI Pipeline via API ---")

    try:
        df = fetch_survey_data()
        if df is None or df.empty:
            raise HTTPException(status_code=400, detail="No data found in database or failed to connect.")

        profile = profile_dataset(df)
        cleaning_plan = ai_cleaning_agent(profile)
        cleaned_df = apply_cleaning(df, cleaning_plan)

        for col in cleaned_df.columns:
            col_lower = col.lower()
            if any(kw in col_lower for kw in ['interest', 'skill', 'technolog', 'career', 'goal']):
                cleaned_df[col] = cleaned_df[col].apply(
                    lambda v: normalize_interest(str(v))
                    if pd.notna(v) and str(v).upper() not in {"UNKNOWN", "INVALID", "NAN"}
                    else v
                )

        structured_df = structure_dataset(cleaned_df)

        for col in structured_df.columns:
            col_lower = col.lower()
            if any(kw in col_lower for kw in ['interest', 'skill', 'technolog', 'career', 'goal']):
                structured_df[col] = structured_df[col].apply(
                    lambda v: normalize_interest(str(v))
                    if pd.notna(v) and str(v).upper() not in {"UNKNOWN", "INVALID", "NAN"}
                    else v
                )

        validate_dataset(structured_df)

        os.makedirs("../outputs", exist_ok=True)
        if '_audit_log' in cleaned_df.attrs:
            structured_df.attrs['_audit_log'] = cleaned_df.attrs['_audit_log']

        export_excel(structured_df)

        export_copy = structured_df.copy()
        output_file = "../outputs/final_clean_dataset.xlsx"
        export_copy.to_excel(output_file, index=False)

        return {
            "status": "success",
            "rows_processed": len(structured_df),
            "output_file": "cleaned_data.xlsx"
        }
    except Exception as e:
        print(f"Pipeline error: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/download/cleaned_data.xlsx")
def download_cleaned_data():
    file_path = Path("../outputs/final_clean_dataset.xlsx")
    if not file_path.exists():
        raise HTTPException(status_code=404, detail="Cleaned data not found. Run pipeline first.")
    return FileResponse(path=file_path, filename="cleaned_data.xlsx")
