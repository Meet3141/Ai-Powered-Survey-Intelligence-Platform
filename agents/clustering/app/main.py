from fastapi import FastAPI

from app.api.routes.analytics import router as analytics_router
from app.api.routes.communities import router as communities_router
from app.api.routes.pipeline import router as pipeline_router
from app.api.routes.reports import router as reports_router
from app.api.routes.students import router as students_router
from app.core.logging import configure_logging
# from app.db.session import init_db

configure_logging()

app = FastAPI(
    title="Agent 3 Community Intelligence Platform",
    version="1.0.0",
    description="Community discovery, student matching, analytics, reporting, and email automation for cleaned student data.",
)


@app.on_event("startup")
def startup_event() -> None:
    print("Agent 3 started successfully")


@app.get("/health")
def health_check():
    return {"status": "ok"}


app.include_router(communities_router)
app.include_router(students_router)
app.include_router(analytics_router)
app.include_router(reports_router)
app.include_router(pipeline_router)



# when database support
# from app.db.session import init_db

# @app.on_event("startup")
# def startup_event() -> None:
#     try:
#         init_db()
#         print("Database connected")
#     except Exception as e:
#         print(f"Database unavailable, continuing in Excel mode: {e}")