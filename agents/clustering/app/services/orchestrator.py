from __future__ import annotations

import logging
from pathlib import Path
from typing import Any
import traceback

from app.core.config import settings
from app.services.analytics import generate_analytics
from app.services.charts import generate_all_charts
from app.services.clustering import (
    cluster_students,
    discover_communities,
    generate_embeddings,
)
from app.services.emailer import send_report_email
from app.services.features import enrich_student_profiles
from app.services.ingestion import load_cleaned_dataset
from app.services.matching import build_student_matches
from app.services.reports import build_report_artifacts
from app.services.summary import generate_ai_summary, generate_faculty_recommendations

logger = logging.getLogger(__name__)


def run_agent3_pipeline(
    input_path: str | Path | None = None,
) -> dict[str, Any]:
    try:
        return _run_agent3_pipeline(input_path)
    except Exception as e:
        print("AGENT3 CRASH:")
        print(str(e))
        traceback.print_exc()
        raise

def _run_agent3_pipeline(
    input_path: str | Path | None = None,
) -> dict[str, Any]:

    logger.info("Starting Agent 3 Pipeline")

    source_path = Path(input_path or settings.input_file)

    logger.info("STEP 1: Loading dataset")
    # Load cleaned Excel
    frame = load_cleaned_dataset(source_path)

    logger.info(
        "Loaded %s student records",
        len(frame)
    )

    logger.info("STEP 2: Building profiles")
    # Build profiles
    frame = enrich_student_profiles(frame)
    logger.info("Profiles built")

    logger.info("STEP 3: Starting embeddings (TF-IDF/SVD — no download)")
    # Generate embeddings
    embeddings = generate_embeddings(
        frame["profile_text"].tolist(),
        settings.embeddings_model,
    )
    logger.info("STEP 3 DONE: Embeddings generated — shape: %s", str(embeddings.shape))

    logger.info("STEP 4: Starting clustering")
    # Community discovery
    labels, cluster_count, clustering_method = cluster_students(
        embeddings
    )
    logger.info("STEP 4 DONE: Clustering complete — method: %s, clusters: %s", clustering_method, cluster_count)

    community_bundle = discover_communities(
        frame,
        embeddings,
        labels,
        clustering_method,
    )

    # Student matching
    similarity_rows, recommendation_rows, top_collaborations = (
        build_student_matches(
            frame,
            embeddings,
        )
    )

    # Analytics
    analytics = generate_analytics(
        frame,
        community_bundle.communities,
    )

    analytics["clustering_method"] = clustering_method
    analytics["cluster_count"] = cluster_count
    analytics["top_collaborations"] = top_collaborations
    analytics["faculty_recommendations"] = generate_faculty_recommendations(community_bundle.communities, analytics)

    analytics["source_file"] = str(
        source_path
    )

    # Charts
    chart_paths = generate_all_charts(
        analytics,
        settings.output_dir,
    )

    # AI Summary
    summary_text = generate_ai_summary(
        analytics
    )

    # Reports
    artifacts = build_report_artifacts(
        analytics,
        community_bundle.communities,
        similarity_rows,
        recommendation_rows,
        chart_paths,
        summary_text,
        settings.output_dir,
    )

    logger.info(
        "Database persistence disabled (Excel-only mode)"
    )

    # Email Faculty
    email_result = send_report_email(
        list(settings.faculty_recipients),
        settings.report_title,
        summary_text,
        [
            artifacts["pdf"],
            artifacts["excel"],
            artifacts["pptx"],
            *chart_paths.values(),
        ],
    )

    if email_result.get("status") == "sent":
        logger.info(
            "Faculty report email sent successfully"
        )

    elif email_result.get("status") == "skipped":
        logger.info(
            "Email skipped: %s",
            email_result.get("message"),
        )

    logger.info(
        "Agent 3 Pipeline Completed Successfully"
    )

    return {
        "source_path": str(source_path),
        "clustering_method": clustering_method,
        "communities": community_bundle.communities,
        "student_community_map":
            community_bundle.student_community_map,
        "similarity_rows": similarity_rows,
        "recommendations":
            recommendation_rows,
        "analytics": analytics,
        "charts": chart_paths,
        "artifacts": artifacts,
        "email_result": email_result,
    }