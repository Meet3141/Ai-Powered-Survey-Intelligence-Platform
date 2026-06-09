from __future__ import annotations

import smtplib
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from pathlib import Path
from typing import Any

from app.core.config import settings


def send_report_email(recipients: list[str] | tuple[str, ...], subject: str, body: str, attachments: list[str]) -> dict[str, Any]:
    if not settings.email_enabled:
        return {"status": "skipped", "message": "Email automation is disabled."}

    if not settings.smtp_host or not settings.email_sender or not recipients:
        return {"status": "skipped", "message": "SMTP configuration is incomplete."}

    message = MIMEMultipart()
    message["From"] = settings.email_sender
    message["To"] = ", ".join(recipients)
    message["Subject"] = subject
    message.attach(MIMEText(body, "plain"))

    for attachment in attachments:
        path = Path(attachment)
        if not path.exists():
            continue
        with path.open("rb") as file_handle:
            part = MIMEApplication(file_handle.read(), Name=path.name)
        part["Content-Disposition"] = f'attachment; filename="{path.name}"'
        message.attach(part)

    with smtplib.SMTP(settings.smtp_host, settings.smtp_port, timeout=30) as smtp:
        smtp.starttls()
        if settings.smtp_user and settings.smtp_password:
            smtp.login(settings.smtp_user, settings.smtp_password)
        smtp.sendmail(settings.email_sender, list(recipients), message.as_string())

    return {"status": "sent", "recipients": list(recipients), "subject": subject}
