from __future__ import annotations

from collections.abc import Iterable

import pandas as pd


SEPARATOR_PATTERN = r"[,;/|]+"


def split_multi_value_text(value: object) -> list[str]:
    if value is None:
        return []
    text = str(value).strip()
    if not text:
        return []
    parts = pd.Series([text]).str.split(SEPARATOR_PATTERN, regex=True).iloc[0]
    return [part.strip() for part in parts if part and part.strip()]


def normalize_token(value: str) -> str:
    return " ".join(str(value).strip().lower().split())


def build_profile_text(row: pd.Series) -> str:
    parts = [row.get("department", ""), row.get("interests", ""), row.get("skill", ""), row.get("career_goal", "")]
    return " ".join(part for part in (str(value).strip() for value in parts) if part)


def build_signal_set(row: pd.Series) -> set[str]:
    values: list[str] = []
    for column in ["department", "interests", "skill", "career_goal"]:
        values.extend(split_multi_value_text(row.get(column, "")) or [str(row.get(column, "")).strip()])
    return {normalize_token(value) for value in values if str(value).strip()}


def enrich_student_profiles(frame: pd.DataFrame) -> pd.DataFrame:
    enriched = frame.copy()
    enriched["profile_text"] = enriched.apply(build_profile_text, axis=1)
    enriched["signals"] = enriched.apply(build_signal_set, axis=1)
    enriched["signals_text"] = enriched["signals"].apply(lambda values: ", ".join(sorted(values)))
    return enriched
