from sqlalchemy import DateTime, Integer, String, Text, func
from sqlalchemy.orm import Mapped, mapped_column

from app.db.base import Base


class FacultyReport(Base):
    __tablename__ = "faculty_reports"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    report_name: Mapped[str] = mapped_column(String(200), nullable=False)
    summary: Mapped[str | None] = mapped_column(Text, nullable=True)
    pdf_path: Mapped[str | None] = mapped_column(Text, nullable=True)
    excel_path: Mapped[str | None] = mapped_column(Text, nullable=True)
    pptx_path: Mapped[str | None] = mapped_column(Text, nullable=True)
    created_at: Mapped[str] = mapped_column(DateTime, server_default=func.now(), nullable=False)
