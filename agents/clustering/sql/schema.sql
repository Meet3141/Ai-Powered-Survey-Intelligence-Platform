CREATE TABLE IF NOT EXISTS communities (
    id SERIAL PRIMARY KEY,
    community_key VARCHAR(120) UNIQUE NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    centroid TEXT,
    size INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS community_members (
    id SERIAL PRIMARY KEY,
    community_id INTEGER NOT NULL REFERENCES communities(id) ON DELETE CASCADE,
    student_id VARCHAR(120) NOT NULL,
    student_name VARCHAR(200),
    department VARCHAR(200),
    membership_weight DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS student_similarity (
    id SERIAL PRIMARY KEY,
    student_id VARCHAR(120) NOT NULL,
    matched_student_id VARCHAR(120) NOT NULL,
    similarity_score DOUBLE PRECISION NOT NULL,
    shared_signals TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS student_recommendations (
    id SERIAL PRIMARY KEY,
    student_id VARCHAR(120) NOT NULL,
    rank INTEGER NOT NULL,
    matched_student_id VARCHAR(120) NOT NULL,
    matched_student_name VARCHAR(200),
    similarity_score DOUBLE PRECISION NOT NULL,
    recommendation_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS faculty_reports (
    id SERIAL PRIMARY KEY,
    report_name VARCHAR(200) NOT NULL,
    summary TEXT,
    pdf_path TEXT,
    excel_path TEXT,
    pptx_path TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS email_logs (
    id SERIAL PRIMARY KEY,
    recipient_email VARCHAR(255) NOT NULL,
    subject VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL,
    error_message TEXT,
    attachment_summary TEXT,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS analytics_snapshots (
    id SERIAL PRIMARY KEY,
    snapshot_type TEXT NOT NULL,
    metrics_json TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
