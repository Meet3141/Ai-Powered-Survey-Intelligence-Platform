from __future__ import annotations

import json
from typing import Any

from sqlalchemy import delete, select
from sqlalchemy.orm import Session

from app.models.analytics import AnalyticsSnapshot
from app.models.community import Community, CommunityMember
from app.models.email_log import EmailLog
from app.models.report import FacultyReport
from app.models.similarity import StudentRecommendation, StudentSimilarity


def reset_run_tables(session: Session) -> None:
    session.execute(delete(CommunityMember))
    session.execute(delete(StudentSimilarity))
    session.execute(delete(StudentRecommendation))
    session.execute(delete(Community))


def save_communities(session: Session, communities: list[dict[str, Any]]) -> None:
    for community in communities:
        row = Community(
            community_key=community["community_key"],
            name=community["name"],
            description=community.get("description"),
            centroid=json.dumps(community.get("centroid")) if community.get("centroid") is not None else None,
            size=int(community.get("size", 0)),
        )
        session.add(row)
    session.flush()


def save_memberships(session: Session, memberships: list[dict[str, Any]]) -> None:
    communities = {community.community_key: community.id for community in session.execute(select(Community)).scalars().all()}
    for membership in memberships:
        community_id = communities.get(membership["community_key"])
        if community_id is None:
            continue
        session.add(
            CommunityMember(
                community_id=community_id,
                student_id=membership["student_id"],
                student_name=membership.get("student_name"),
                department=membership.get("department"),
                membership_weight=float(membership.get("membership_weight", 1.0)),
            )
        )


def save_similarity(session: Session, similarity_rows: list[dict[str, Any]]) -> None:
    for row in similarity_rows:
        session.add(
            StudentSimilarity(
                student_id=row["student_id"],
                matched_student_id=row["matched_student_id"],
                similarity_score=float(row["similarity_score"]),
                shared_signals=json.dumps(row.get("shared_signals", [])),
            )
        )


def save_recommendations(session: Session, recommendation_rows: list[dict[str, Any]]) -> None:
    for row in recommendation_rows:
        session.add(
            StudentRecommendation(
                student_id=row["student_id"],
                rank=int(row["rank"]),
                matched_student_id=row["matched_student_id"],
                matched_student_name=row.get("matched_student_name"),
                similarity_score=float(row["similarity_score"]),
                recommendation_text=row["recommendation_text"],
            )
        )


def save_analytics_snapshot(session: Session, snapshot_type: str, metrics: dict[str, Any]) -> None:
    session.add(AnalyticsSnapshot(snapshot_type=snapshot_type, metrics_json=json.dumps(metrics, default=str)))


def save_report(session: Session, report_name: str, summary: str, pdf_path: str, excel_path: str, pptx_path: str) -> None:
    session.add(
        FacultyReport(
            report_name=report_name,
            summary=summary,
            pdf_path=pdf_path,
            excel_path=excel_path,
            pptx_path=pptx_path,
        )
    )


def save_email_log(session: Session, recipient_email: str, subject: str, status: str, error_message: str | None, attachment_summary: str | None) -> None:
    session.add(
        EmailLog(
            recipient_email=recipient_email,
            subject=subject,
            status=status,
            error_message=error_message,
            attachment_summary=attachment_summary,
        )
    )
