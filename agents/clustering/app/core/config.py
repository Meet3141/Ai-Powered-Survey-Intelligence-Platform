from dataclasses import dataclass
from pathlib import Path
import os


@dataclass(frozen=True)
class Settings:
    project_root: Path = Path(__file__).resolve().parents[2]
    input_file: Path = Path(os.getenv("AGENT3_INPUT_FILE", str(Path(__file__).resolve().parents[3] / "outputs" / "final_clean_dataset.xlsx")))
    output_dir: Path = Path(os.getenv("AGENT3_OUTPUT_DIR", str(Path(__file__).resolve().parents[3] / "outputs")))
    database_url: str = os.getenv(
        "DATABASE_URL",
        "postgresql+psycopg2://postgres:postgres@localhost:5432/survey_ai",
    )
    embeddings_model: str = os.getenv("EMBEDDINGS_MODEL", "all-MiniLM-L6-v2")
    email_enabled: bool = os.getenv("EMAIL_ENABLED", "true").lower() in {"1", "true", "yes", "on"}
    smtp_host: str = os.getenv("SMTP_HOST", "")
    smtp_port: int = int(os.getenv("SMTP_PORT", "587"))
    smtp_user: str = os.getenv("SMTP_USER", "")
    smtp_password: str = os.getenv("SMTP_PASSWORD", "")
    email_sender: str = os.getenv("EMAIL_SENDER", os.getenv("SMTP_USER", ""))
    faculty_recipients: tuple[str, ...] = tuple(
        email.strip() for email in os.getenv("FACULTY_RECIPIENTS", "").split(",") if email.strip()
    )
    report_title: str = os.getenv("REPORT_TITLE", "Student Community Intelligence Report")


settings = Settings()
