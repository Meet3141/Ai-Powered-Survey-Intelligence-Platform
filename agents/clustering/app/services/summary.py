from __future__ import annotations

import os
import json
from typing import Any

try:
    from groq import Groq
except Exception:  # pragma: no cover - optional dependency
    Groq = None

# Import community recommendations taxonomy for theme-aware recs
from app.services.clustering import COMMUNITY_RECOMMENDATIONS, _DEFAULT_RECOMMENDATIONS


def generate_ai_summary(metrics: dict[str, Any]) -> str:
    api_key = os.getenv("GROQ_API_KEY", "").strip()
    if api_key and Groq is not None:
        try:
            client = Groq(api_key=api_key)
            total = metrics.get("total_students", 0)
            communities = metrics.get("community_size_analysis", [])
            top_interest = (metrics.get("interest_distribution") or [{}])[0].get("label", "diverse interests")
            top_skill = (metrics.get("skill_distribution") or [{}])[0].get("label", "various skills")
            top_dept = (metrics.get("department_distribution") or [{}])[0].get("label", "multiple departments")

            prompt = (
                f"You are writing a professional executive summary for a faculty academic report. "
                f"Dataset: {total} students across {len(communities)} communities. "
                f"Top department: {top_dept}. Top interest: {top_interest}. Top skill: {top_skill}. "
                f"Write 3 concise professional sentences: (1) overview of student body, "
                f"(2) key insight about community distribution, (3) one concrete action recommendation. "
                f"Be specific and data-driven. Avoid generic filler phrases."
            )
            response = client.chat.completions.create(
                model=os.getenv("GROQ_MODEL", "llama-3.3-70b-versatile"),
                messages=[{"role": "user", "content": prompt}],
                temperature=0.2,
            )
            content = response.choices[0].message.content or ""
            if content.strip():
                return content.strip()
        except Exception:
            pass

    # Fallback summary
    total_students = metrics.get("total_students", 0)
    top_interest = (metrics.get("interest_distribution") or [{}])[:1]
    top_interest_text = top_interest[0]["label"] if top_interest else "student interests"
    top_skill = (metrics.get("skill_distribution") or [{}])[:1]
    top_skill_text = top_skill[0]["label"] if top_skill else "technical skills"
    communities = metrics.get("community_size_analysis", [])
    return (
        f"This report analyzes {total_students} students organized into {len(communities)} "
        f"distinct communities. The strongest emerging theme is {top_interest_text}, with "
        f"{top_skill_text} as the most prevalent skill. Faculty should leverage these community "
        f"structures to design targeted programming, peer mentorship, and industry engagement "
        f"opportunities that align with students' stated interests and career goals."
    )


def generate_faculty_recommendations(
    communities: list[dict[str, Any]],
    analytics: dict[str, Any],
) -> list[str]:
    """
    Generate theme-aware faculty recommendations based on actual community names.
    No size threshold — recommendations fire for all communities regardless of member count.
    """
    recs: list[str] = []
    seen: set[str] = set()

    def _add(rec: str) -> None:
        if rec not in seen:
            seen.add(rec)
            recs.append(rec)

    # 1. Community-specific recommendations from taxonomy
    for community in communities:
        name = community.get("name", "")
        size = community.get("size", 0)
        theme_recs = COMMUNITY_RECOMMENDATIONS.get(name, [])
        if theme_recs:
            # Add the top 2 recs per community (avoid flooding the list)
            for rec in theme_recs[:2]:
                _add(rec)
        else:
            # Fallback: derive a reasonable rec from the community name
            friendly = name.replace(" Community", "").strip()
            _add(f"Launch a dedicated {friendly} Club with faculty advisor oversight.")

    # 2. Cross-community strategic recommendations
    top_collabs = analytics.get("top_collaborations", [])
    if any(float(col.get("similarity_score", 0)) > 85.0 for col in top_collabs):
        _add("Form cross-community project teams for students with high similarity scores.")

    departments = analytics.get("department_distribution", [])
    if len(departments) > 1:
        _add("Launch an Interdisciplinary Innovation Challenge spanning all communities.")

    # 3. Universal recommendations (added only if needed to reach minimum 5)
    universal_recs = [
        "Establish a Faculty Mentorship Programme pairing students with academic advisors.",
        "Host a semester-end Community Showcase where each group presents their work.",
        "Organize industry networking events aligned with top student career goals.",
        "Review curriculum for alignment with emerging student interest clusters.",
        "Encourage national hackathon and competition participation across communities.",
        "Establish undergraduate research fellowships for high-performing community leaders.",
    ]
    for rec in universal_recs:
        if len(recs) >= 10:
            break
        _add(rec)

    return recs[:10]
