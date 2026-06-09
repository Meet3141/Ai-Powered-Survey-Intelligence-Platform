from sqlalchemy import select
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.deps import get_db
from app.models.report import FacultyReport

router = APIRouter(prefix="", tags=["reports"])


@router.get("/reports")
def list_reports(db: Session = Depends(get_db)):
    rows = db.execute(select(FacultyReport).order_by(FacultyReport.created_at.desc())).scalars().all()
    if not rows:
        raise HTTPException(status_code=404, detail="No reports found")
    return [
        {
            "report_name": row.report_name,
            "summary": row.summary,
            "pdf_path": row.pdf_path,
            "excel_path": row.excel_path,
            "pptx_path": row.pptx_path,
            "created_at": row.created_at,
        }
        for row in rows
    ]
