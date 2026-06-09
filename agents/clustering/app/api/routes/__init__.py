from app.api.routes.analytics import router as analytics_router
from app.api.routes.communities import router as communities_router
from app.api.routes.pipeline import router as pipeline_router
from app.api.routes.reports import router as reports_router
from app.api.routes.students import router as students_router

__all__ = [
    "analytics_router",
    "communities_router",
    "pipeline_router",
    "reports_router",
    "students_router",
]
