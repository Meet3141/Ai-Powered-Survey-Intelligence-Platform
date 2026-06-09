# Agent 3 Community Intelligence Platform

Agent 3 is a standalone Python service for community discovery, student matching, faculty analytics, chart generation, report creation, and email automation.

## What it does

- Reads cleaned student data from `inputs/cleaned_data.xlsx`
- Normalizes student records
- Builds semantic profiles from department, interests, skills, and career goals
- Creates embeddings with `all-MiniLM-L6-v2`
- Discovers communities with HDBSCAN and falls back to KMeans when needed
- Computes student similarity and peer recommendations
- Generates faculty analytics and visual charts
- Produces PDF, Excel, and PowerPoint reports
- Sends reports by email when SMTP is configured
- Exposes FastAPI endpoints for dashboard access

## Folder Structure

```text
agent3-community-intelligence/
├── app/
│   ├── api/
│   │   └── routes/
│   ├── core/
│   ├── db/
│   ├── models/
│   └── services/
├── inputs/
├── outputs/
├── sql/
├── .env.example
├── README.md
└── requirements.txt
```

## Setup

1. Create a virtual environment.
2. Install dependencies:

```bash
pip install -r requirements.txt
```

3. Copy `.env.example` to `.env` and set values.
4. Put the cleaned dataset at `inputs/cleaned_data.xlsx`.
5. Create the PostgreSQL schema from `sql/schema.sql`.

## Run the API

```bash
uvicorn app.main:app --reload
```

## Trigger the Pipeline

```bash
curl -X POST http://127.0.0.1:8000/pipeline/run
```

## Endpoints

- `GET /health`
- `GET /communities`
- `GET /community/{id}`
- `GET /student/{id}/matches`
- `GET /student/{id}/communities`
- `GET /analytics`
- `GET /reports`
- `GET /graphs`
- `POST /pipeline/run`

## Output Files

- `outputs/faculty_report.pdf`
- `outputs/faculty_report.xlsx`
- `outputs/faculty_report.pptx`
- `outputs/*.png`

## Notes

- Email sending is enabled when `EMAIL_ENABLED=true` and SMTP credentials are provided.
- The service persists communities, memberships, similarities, recommendations, reports, and snapshots in PostgreSQL.
- If HDBSCAN is unavailable or cannot form stable clusters, the pipeline falls back to KMeans.
