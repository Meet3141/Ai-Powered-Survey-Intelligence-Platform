from datetime import datetime
from typing import Any

from pydantic import BaseModel


class CommunityOut(BaseModel):
    id: int
    community_key: str
    name: str
    description: str | None = None
    size: int
    created_at: datetime | None = None


class CommunityDetailOut(CommunityOut):
    centroid: str | None = None
    members: list[dict[str, Any]]


class MatchOut(BaseModel):
    matched_student_id: str
    matched_student_name: str | None = None
    similarity_score: float
    recommendation_text: str


class StudentCommunitiesOut(BaseModel):
    student_id: str
    communities: list[dict[str, Any]]


class AnalyticsOut(BaseModel):
    snapshot_type: str
    metrics: dict[str, Any]
    created_at: datetime | None = None


class ReportOut(BaseModel):
    report_name: str
    summary: str | None = None
    pdf_path: str | None = None
    excel_path: str | None = None
    pptx_path: str | None = None
    created_at: datetime | None = None


class GraphOut(BaseModel):
    file_name: str
    file_path: str


class PipelineRunResponse(BaseModel):
    status: str
    message: str
    artifacts: dict[str, Any]
