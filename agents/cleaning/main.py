import os
from pathlib import Path
import pandas as pd

from profiler import profile_dataset
from agent import ai_cleaning_agent
from cleaner import apply_cleaning, normalize_interest, normalize_skill
from structure import structure_dataset
from validator import validate_dataset
from database import fetch_survey_data
from exporter import export_excel


def main():
    print("--- Starting SurveyClean AI Pipeline ---")

    # 1. Load Dataset from Database
    df = fetch_survey_data()

    if df is None or df.empty:
        print("Error: No data found in database or failed to connect.")
        return

    print(f"Initial Shape from DB: {df.shape}")

    # 2. Profile Dataset
    print("\nProfiling Dataset...")
    profile = profile_dataset(df)

    # 3. Get AI Cleaning Plan
    print("\nConsulting AI Specialist for Cleaning Plan...")
    cleaning_plan = ai_cleaning_agent(profile)

    # 4. Apply Cleaning (includes tech normalization per-cell)
    print("\nApplying Cleaning Steps...")
    cleaned_df = apply_cleaning(df, cleaning_plan)

    # 5. Post-Clean: Apply canonical normalization to interest/skill columns
    #    This runs AFTER the LLM-assisted cleaning step to catch any
    #    residual corrupted tokens that survived cleaning.
    print("\nApplying canonical tech-term normalization...")
    for col in cleaned_df.columns:
        col_lower = col.lower()
        if any(kw in col_lower for kw in ['interest', 'skill', 'technolog', 'career', 'goal']):
            cleaned_df[col] = cleaned_df[col].apply(
                lambda v: normalize_interest(str(v))
                if pd.notna(v) and str(v).upper() not in {"UNKNOWN", "INVALID", "NAN"}
                else v
            )

    # 6. Structure Dataset
    print("\nStructuring Dataset...")
    structured_df = structure_dataset(cleaned_df)

    # 7. Post-Structure: normalize interest/skill columns again on the wide pivot
    print("Normalizing structured interest/skill columns...")
    for col in structured_df.columns:
        col_lower = col.lower()
        if any(kw in col_lower for kw in ['interest', 'skill', 'technolog', 'career', 'goal']):
            structured_df[col] = structured_df[col].apply(
                lambda v: normalize_interest(str(v))
                if pd.notna(v) and str(v).upper() not in {"UNKNOWN", "INVALID", "NAN"}
                else v
            )

    # 8. Validate Final Output
    validate_dataset(structured_df)

    # 9. Export Results (main file + audit log)
    print("\nExporting Results...")
    os.makedirs("../outputs", exist_ok=True)

    # Transfer the audit log from cleaned_df to structured_df for the exporter
    if '_audit_log' in cleaned_df.attrs:
        structured_df.attrs['_audit_log'] = cleaned_df.attrs['_audit_log']

    export_excel(structured_df)

    # Also save a copy as 'final_clean_dataset.xlsx' for convenience
    export_copy = structured_df.copy()
    export_copy.to_excel("../outputs/final_clean_dataset.xlsx", index=False)

    print("\n--- Pipeline Completed Successfully ---")


if __name__ == "__main__":
    main()