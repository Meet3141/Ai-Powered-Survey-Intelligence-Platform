from __future__ import annotations

from collections import Counter, defaultdict
from typing import Any

import pandas as pd


def _flatten_tokens(frame: pd.DataFrame, column: str) -> list[str]:
    tokens: list[str] = []
    for value in frame[column].tolist():
        if isinstance(value, (set, list, tuple)):
            tokens.extend([str(item).strip().lower() for item in value if str(item).strip()])
        else:
            tokens.extend([part.strip().lower() for part in str(value).split(",") if part.strip()])
    return tokens


def _distribution(tokens: list[str], top_n: int = 10) -> list[dict[str, Any]]:
    counter = Counter(tokens)
    return [{"label": label, "count": count} for label, count in counter.most_common(top_n)]


def generate_analytics(frame: pd.DataFrame, communities: list[dict[str, Any]]) -> dict[str, Any]:
    department_counts = Counter(frame["department"].str.strip().str.lower())
    interest_counts = Counter(_flatten_tokens(frame, "interests"))
    skill_counts = Counter(_flatten_tokens(frame, "skill"))
    career_goal_counts = Counter(_flatten_tokens(frame, "career_goal"))

    department_interest: dict[str, Counter[str]] = defaultdict(Counter)
    skill_career: dict[str, Counter[str]] = defaultdict(Counter)

    for _, row in frame.iterrows():
        department = str(row["department"]).strip().title() or "Unknown"
        for interest in [part.strip().lower() for part in str(row["interests"]).split(",") if part.strip()]:
            department_interest[department][interest] += 1
        for skill in [part.strip().lower() for part in str(row["skill"]).split(",") if part.strip()]:
            skill_career[skill][str(row["career_goal"]).strip().lower() or "unknown"] += 1

    community_sizes = sorted(
        ({"label": item["name"], "count": int(item.get("size", 0))} for item in communities),
        key=lambda row: row["count"],
        reverse=True,
    )

    return {
        "total_students": int(frame["student_id"].nunique()),
        "department_distribution": _distribution([str(value).strip().title() for value in frame["department"]], top_n=20),
        "interest_distribution": _distribution(list(interest_counts.elements()), top_n=20),
        "skill_distribution": _distribution(list(skill_counts.elements()), top_n=20),
        "career_goal_distribution": _distribution(list(career_goal_counts.elements()), top_n=20),
        "most_popular_technologies": _distribution(list(skill_counts.elements()), top_n=10),
        "most_requested_learning_topics": _distribution(list(career_goal_counts.elements()), top_n=10),
        "most_active_communities": community_sizes[:10],
        "community_size_analysis": community_sizes,
        "department_vs_interest": {
            department: _distribution(list(counter.elements()), top_n=10)
            for department, counter in department_interest.items()
        },
        "skill_vs_career_goal": {
            skill: _distribution(list(counter.elements()), top_n=10)
            for skill, counter in skill_career.items()
        },
        "faculty_recommendations": [
            f"{round((count / max(1, len(frame))) * 100, 1)}% of students are interested in {label.title()}"
            for label, count in interest_counts.most_common(5)
        ],
    }
