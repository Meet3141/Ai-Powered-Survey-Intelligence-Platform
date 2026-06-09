from typing import Optional

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from pathlib import Path

from app.services.orchestrator import run_agent3_pipeline
from app.core.config import settings

router = APIRouter(prefix="", tags=["pipeline"])


class PipelineRunRequest(BaseModel):
    path: Optional[str] = None


@router.post("/pipeline/run")
def run_pipeline(payload: Optional[PipelineRunRequest] = None):
    try:
        # Determine path: use provided path, otherwise use default inputs file
        if payload and payload.path:
            p = Path(payload.path)
        else:
            p = Path(settings.input_file)

        if not p.exists():
            raise HTTPException(status_code=400, detail=f"Path not found: {p}")

        if p.suffix.lower() not in {".xlsx", ".xls", ".csv"}:
            raise HTTPException(status_code=400, detail="Supported file types: .xlsx, .xls, .csv")

        result = run_agent3_pipeline(input_path=str(p))

        return {
            "status": "success",
            "message": "Agent 3 pipeline completed successfully",
            "artifacts": result.get("artifacts"),
            "email_result": result.get("email_result"),
        }
    except HTTPException:
        raise
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc)) from exc
