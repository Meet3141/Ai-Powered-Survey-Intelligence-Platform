from pathlib import Path
import json

from sqlalchemy import select
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.core.config import settings
from app.db.deps import get_db
from app.models.analytics import AnalyticsSnapshot

router = APIRouter(prefix="", tags=["analytics"])


@router.get("/analytics")
def get_analytics(db: Session = Depends(get_db)):
    snapshot = (
        db.execute(
            select(AnalyticsSnapshot).order_by(AnalyticsSnapshot.created_at.desc())
        )
        .scalars()
        .first()
    )
    if snapshot is None:
        raise HTTPException(status_code=404, detail="Analytics not available")
    return {
        "snapshot_type": snapshot.snapshot_type,
        "metrics": json.loads(snapshot.metrics_json),
        "created_at": snapshot.created_at,
    }


@router.get("/graphs")
def get_graphs():
    output_dir = Path(settings.output_dir)
    if not output_dir.exists():
        return []
    return [
        {
            "file_name": file_path.name,
            "file_path": str(file_path),
        }
        for file_path in sorted(output_dir.glob("*.png"))
    ]
