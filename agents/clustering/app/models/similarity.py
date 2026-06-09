from sqlalchemy import DateTime, Float, Integer, String, Text, func
from sqlalchemy.orm import Mapped, mapped_column

from app.db.base import Base


class StudentSimilarity(Base):
    __tablename__ = "student_similarity"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    student_id: Mapped[str] = mapped_column(String(120), nullable=False, index=True)
    matched_student_id: Mapped[str] = mapped_column(String(120), nullable=False, index=True)
    similarity_score: Mapped[float] = mapped_column(Float, nullable=False)
    shared_signals: Mapped[str | None] = mapped_column(Text, nullable=True)
    created_at: Mapped[str] = mapped_column(DateTime, server_default=func.now(), nullable=False)


class StudentRecommendation(Base):
    __tablename__ = "student_recommendations"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    student_id: Mapped[str] = mapped_column(String(120), nullable=False, index=True)
    rank: Mapped[int] = mapped_column(Integer, nullable=False)
    matched_student_id: Mapped[str] = mapped_column(String(120), nullable=False, index=True)
    matched_student_name: Mapped[str | None] = mapped_column(String(200), nullable=True)
    similarity_score: Mapped[float] = mapped_column(Float, nullable=False)
    recommendation_text: Mapped[str] = mapped_column(Text, nullable=False)
    created_at: Mapped[str] = mapped_column(DateTime, server_default=func.now(), nullable=False)
