from typing import Optional
import os
import requests
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
        # Determine path
        if payload and payload.path:
            p = Path(payload.path)
        else:
            p = Path(settings.input_file)

        # Check if we should download from Agent 2 directly
        agent2_url = os.getenv("AGENT2_URL")
        if agent2_url:
            try:
                download_url = f"{agent2_url.rstrip('/')}/download/cleaned_data.xlsx"
                print(f"Downloading cleaned data from {download_url}...")
                response = requests.get(download_url, timeout=30)
                response.raise_for_status()
                
                p.parent.mkdir(parents=True, exist_ok=True)
                with open(p, "wb") as f:
                    f.write(response.content)
                print(f"Successfully downloaded to {p}")
            except Exception as e:
                print(f"Warning: Failed to download from Agent 2: {e}")

        if not p.exists():
            raise HTTPException(status_code=400, detail=f"Path not found: {p}")

        if p.suffix.lower() not in {".xlsx", ".xls", ".csv"}:
            raise HTTPException(status_code=400, detail="Supported file types: .xlsx, .xls, .csv")

        result = run_agent3_pipeline(input_path=str(p))

        # Format as requested by user
        artifacts = result.get("artifacts", {})
        communities = result.get("communities", [])
        
        return {
            "status": "success",
            "communities": len(communities),
            "pdf_report": artifacts.get("pdf", ""),
            "excel_report": artifacts.get("excel", ""),
            "ppt_report": artifacts.get("pptx", ""),
            "artifacts": artifacts
        }
    except HTTPException:
        raise
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc)) from exc


@router.get("/download/{filename}")
def download_file(filename: str):
    from fastapi.responses import FileResponse
    file_path = settings.output_dir / filename

    if not file_path.exists():
        # Fallback check if it's the raw dataset name mismatch
        if filename == "cleaned_data.xlsx":
            file_path = settings.output_dir / "final_clean_dataset.xlsx"
            
        if not file_path.exists():
            raise HTTPException(status_code=404, detail="File not found")

    return FileResponse(
        path=file_path,
        filename=filename,
        media_type="application/octet-stream"
    )
