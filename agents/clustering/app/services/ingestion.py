from pathlib import Path

import pandas as pd

from app.core.config import settings


COLUMN_ALIASES = {
    "student_id": ["student_id", "user_id", "id", "sid"],
    "name": ["name", "student_name", "fullname", "full_name", "same"],
    "department": ["department", "dept", "branch", "programme"],
    "interests": ["interests", "interest", "hobbies", "focus_area"],
    "skill": ["skill", "skills", "strengths", "technical_skills", "technologies", "kill"],
    "career_goal": ["career_goal", "career goals", "goal", "goals", "future_goal"],
}

REQUIRED_COLUMNS = ["student_id", "name", "department", "interests", "skill", "career_goal"]


def load_cleaned_dataset(source_path: str | Path | None = None) -> pd.DataFrame:
    """Load cleaned dataset from Excel/CSV file only.

    If `source_path` is None, use the default inputs/cleaned_data.xlsx path from settings.
    """
    if source_path is None:
        path = Path(settings.input_file)
    else:
        path = Path(source_path)

    if not path.exists():
        raise FileNotFoundError(f"Input file not found: {path}")

    suffix = path.suffix.lower()
    if suffix in {".xlsx", ".xls"}:
        frame = pd.read_excel(path)
    elif suffix == ".csv":
        frame = pd.read_csv(path)
    else:
        raise ValueError("Supported inputs are .xlsx, .xls, and .csv")

    return normalize_dataset(frame)


def normalize_dataset(frame: pd.DataFrame) -> pd.DataFrame:
    renamed = frame.copy()
    lower_lookup = {column.lower().strip(): column for column in renamed.columns}
    rename_map: dict[str, str] = {}

    for canonical, aliases in COLUMN_ALIASES.items():
        matched = False
        
        # Pass 1: Exact match
        for alias in aliases:
            source_name = lower_lookup.get(alias)
            if source_name:
                rename_map[source_name] = canonical
                matched = True
                break
                
        # Pass 2: Substring match (fallback for LLM-hallucinated long headers)
        if not matched:
            for alias in aliases:
                for lower_col, orig_col in lower_lookup.items():
                    # Check if alias is in the lowercased column header and hasn't been claimed
                    if alias in lower_col and orig_col not in rename_map.values() and orig_col not in rename_map:
                        rename_map[orig_col] = canonical
                        matched = True
                        break
                if matched:
                    break

    renamed = renamed.rename(columns=rename_map)

    if "student_id" not in renamed.columns:
        renamed["student_id"] = [str(index + 1) for index in range(len(renamed))]

    if "name" not in renamed.columns:
        renamed["name"] = renamed["student_id"].astype(str)

    for column in REQUIRED_COLUMNS:
        if column not in renamed.columns:
            renamed[column] = ""

    normalized = renamed[REQUIRED_COLUMNS].copy()
    for column in REQUIRED_COLUMNS:
        normalized[column] = normalized[column].fillna("").astype(str).str.strip()

    normalized = normalized[normalized["student_id"].astype(str).str.strip() != ""]
    normalized = normalized.reset_index(drop=True)
    return normalized
