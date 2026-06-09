from __future__ import annotations

from collections import Counter
from typing import Any

import numpy as np
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity


def _shared_signals(left: set[str], right: set[str]) -> list[str]:
    return sorted(left.intersection(right))


def build_student_matches(frame: pd.DataFrame, embeddings: np.ndarray, top_n: int = 3) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    if len(frame) == 0:
        return [], []

    similarity_matrix = cosine_similarity(embeddings)
    similarity_rows: list[dict[str, Any]] = []
    recommendation_rows: list[dict[str, Any]] = []

    for index, student in frame.iterrows():
        scores = similarity_matrix[index].copy()
        scores[index] = -1
        candidate_indexes = np.argsort(scores)[::-1][:top_n]
        for rank, candidate_index in enumerate(candidate_indexes, start=1):
            candidate = frame.iloc[int(candidate_index)]
            score = float(scores[int(candidate_index)] * 100)
            shared = _shared_signals(student["signals"], candidate["signals"])
            shared_text = ", ".join(shared[:5]) if shared else "Common academic profile signals"
            similarity_rows.append(
                {
                    "student_id": str(student["student_id"]),
                    "matched_student_id": str(candidate["student_id"]),
                    "similarity_score": round(score, 2),
                    "shared_signals": shared,
                }
            )
            recommendation_rows.append(
                {
                    "student_id": str(student["student_id"]),
                    "rank": rank,
                    "matched_student_id": str(candidate["student_id"]),
                    "matched_student_name": candidate["name"],
                    "similarity_score": round(score, 2),
                    "recommendation_text": f"Connect with {candidate['name']} because you both share {shared_text}.",
                }
            )

    top_collaborations = []
    pairs = []
    for i in range(len(frame)):
        for j in range(i + 1, len(frame)):
            score = float(similarity_matrix[i, j] * 100)
            pairs.append((i, j, score))
            
    pairs.sort(key=lambda x: x[2], reverse=True)
    
    for i, j, score in pairs[:10]:
        student_a = frame.iloc[i]
        student_b = frame.iloc[j]
        
        interests_a = {p.strip().title() for p in str(student_a.get("interests", "")).split(",") if p.strip()}
        interests_b = {p.strip().title() for p in str(student_b.get("interests", "")).split(",") if p.strip()}
        shared_interests = sorted(interests_a.intersection(interests_b))
        
        skills_a = {p.strip().title() for p in str(student_a.get("skill", "")).split(",") if p.strip()}
        skills_b = {p.strip().title() for p in str(student_b.get("skill", "")).split(",") if p.strip()}
        shared_skills = sorted(skills_a.intersection(skills_b))
        
        reason = "Both students have highly similar academic profile embeddings."
        if shared_interests and shared_skills:
            reason = f"Both students are pursuing {shared_interests[0]} careers and possess complementary {shared_skills[0]} skills."
        elif shared_interests:
            reason = f"Both students are highly interested in {shared_interests[0]}."
        elif shared_skills:
            reason = f"Both students share strong technical capabilities in {shared_skills[0]}."
            
        top_collaborations.append({
            "student_a": str(student_a.get("name", "Unknown")).title(),
            "student_b": str(student_b.get("name", "Unknown")).title(),
            "similarity_score": round(score, 1),
            "shared_interests": shared_interests,
            "shared_skills": shared_skills,
            "reason": reason
        })

    return similarity_rows, recommendation_rows, top_collaborations
