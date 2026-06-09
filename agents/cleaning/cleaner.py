import re
import os
import emoji
import pandas as pd
from rapidfuzz import fuzz, process

# ============================================================
# COMPREHENSIVE TECH NORMALIZATION DICTIONARY
# Maps corrupted / abbreviated / OCR-garbled forms → canonical
# ============================================================
TECH_NORMALIZATION = {
    # AI / Machine Learning
    "aiml": "AI/ML",
    "ai/ml": "AI/ML",
    "ai ml": "AI/ML",
    "artificial intelligence": "Artificial Intelligence",
    "artificialintelligence": "Artificial Intelligence",
    "a.i": "AI",
    "a.i.": "AI",
    "machine learning": "Machine Learning",
    "machinelearning": "Machine Learning",
    "deep learning": "Deep Learning",
    "deeplearning": "Deep Learning",
    "data science": "Data Science",
    "datascience": "Data Science",
    "nlp": "NLP",
    "natural language processing": "Natural Language Processing",
    "computer vision": "Computer Vision",
    "reinforcement learning": "Reinforcement Learning",
    "tensorflow": "TensorFlow",
    "tensor flow": "TensorFlow",
    "pytorch": "PyTorch",
    "py torch": "PyTorch",
    "keras": "Keras",
    "scikit learn": "Scikit-Learn",
    "sklearn": "Scikit-Learn",
    "pandas": "Pandas",
    "numpy": "NumPy",
    "matplotlib": "Matplotlib",

    # Web Development
    "nodejs": "Node.js",
    "node js": "Node.js",
    "node.js": "Node.js",
    "rode.is": "Node.js",
    "rode js": "Node.js",
    "rode.js": "Node.js",
    "reactjs": "React.js",
    "react js": "React.js",
    "vuejs": "Vue.js",
    "vue js": "Vue.js",
    "angularjs": "Angular",
    "angular js": "Angular",
    "nextjs": "Next.js",
    "next js": "Next.js",
    "expressjs": "Express.js",
    "express js": "Express.js",
    "javascript": "JavaScript",
    "java script": "JavaScript",
    "typescript": "TypeScript",
    "html css": "HTML/CSS",
    "html/css": "HTML/CSS",
    "fullstack": "Full Stack",
    "full stack": "Full Stack",
    "frontend": "Frontend",
    "front end": "Frontend",
    "backend": "Backend",
    "back end": "Backend",

    # Cloud / DevOps
    "aws": "AWS",
    "amazon web services": "AWS",
    "loud computing": "Cloud Computing",
    "coud computing": "Cloud Computing",
    "cloud computing": "Cloud Computing",
    "cloudcomputing": "Cloud Computing",
    "azure": "Azure",
    "microsoft azure": "Azure",
    "gcp": "GCP",
    "google cloud": "Google Cloud",
    "devops": "DevOps",
    "dev ops": "DevOps",
    "ci/cd": "CI/CD",
    "cicd": "CI/CD",
    "docker": "Docker",
    "kubernetes": "Kubernetes",
    "k8s": "Kubernetes",

    # Cybersecurity
    "cybersecurity": "Cybersecurity",
    "cyber security": "Cybersecurity",
    "cyber-security": "Cybersecurity",
    "infosec": "Information Security",
    "penetration testing": "Penetration Testing",
    "penetration fester": "Penetration Testing",
    "penetration tester": "Penetration Testing",
    "pen testing": "Penetration Testing",
    "pentesting": "Penetration Testing",
    "ethical hacking": "Ethical Hacking",
    "network security": "Network Security",
    "networksecurity": "Network Security",

    # Robotics / IoT / Embedded
    "iot": "IoT",
    "internet of things": "IoT",
    "arduino": "Arduino",
    "raspberry pi": "Raspberry Pi",
    "embedded systems": "Embedded Systems",
    "embedded": "Embedded Systems",
    "robotics": "Robotics",

    # Databases
    "sql": "SQL",
    "mysql": "MySQL",
    "postgresql": "PostgreSQL",
    "postgres": "PostgreSQL",
    "mongodb": "MongoDB",
    "nosql": "NoSQL",

    # Mobile
    "android": "Android",
    "ios": "iOS",
    "flutter": "Flutter",
    "react native": "React Native",

    # Entrepreneurship / Business
    "entrepreneurship": "Entrepreneurship",
    "entrepreneur": "Entrepreneurship",
    "startup": "Startup",
    "product management": "Product Management",
    "project management": "Project Management",
    "business analytics": "Business Analytics",

    # Other tech
    "blockchain": "Blockchain",
    "ar/vr": "AR/VR",
    "augmented reality": "Augmented Reality",
    "virtual reality": "Virtual Reality",
    "game development": "Game Development",
    "game dev": "Game Development",
}

# Build lowercased lookup for fast exact matching
_TECH_NORM_LOWER = {k.lower(): v for k, v in TECH_NORMALIZATION.items()}

# Canonical list for fuzzy fallback (only the keys)
_TECH_KEYS = list(_TECH_NORM_LOWER.keys())


# Junk patterns
JUNK_PATTERNS = [
    r'^[0-9]+$',
    r'^[@#$%^&*()]+$',
    r'^[asdfghjkl]+$'
]


# ============================================================
# NORMALIZATION FUNCTIONS
# ============================================================

def normalize_tech_term(token: str) -> str:
    """
    Normalize a single technical token:
    1. Strip & lowercase
    2. Exact match against TECH_NORMALIZATION
    3. Fuzzy match (threshold 85) as fallback
    4. Return original .title() if no match
    """
    stripped = token.strip()
    if not stripped:
        return stripped

    lower = stripped.lower()

    # Exact match
    if lower in _TECH_NORM_LOWER:
        return _TECH_NORM_LOWER[lower]

    # Fuzzy match — only trigger for tokens of reasonable length
    if len(lower) >= 4:
        match = process.extractOne(lower, _TECH_KEYS, scorer=fuzz.ratio)
        if match and match[1] >= 85:
            return _TECH_NORM_LOWER[match[0]]

    return stripped.title()


def normalize_interest(value: str) -> str:
    """Normalize a comma-separated interests string."""
    if not value or pd.isna(value):
        return value
    parts = [p.strip() for p in str(value).split(",") if p.strip()]
    return ", ".join(normalize_tech_term(p) for p in parts)


def normalize_skill(value: str) -> str:
    """Normalize a comma-separated skills string."""
    if not value or pd.isna(value):
        return value
    parts = [p.strip() for p in str(value).split(",") if p.strip()]
    return ", ".join(normalize_tech_term(p) for p in parts)


# ============================================================
# BASIC TEXT CLEANING UTILITIES
# ============================================================

def remove_extra_spaces(text):
    return text.strip()


def normalize_text(text):
    return text.title()


def remove_emojis(text):
    return emoji.replace_emoji(text, replace='')


def remove_special_characters(text):
    return re.sub(r'[^a-zA-Z0-9@._\s\-/]', '', text)


def correct_spelling(text):
    """
    Only apply TextBlob spelling correction to plain natural-language phrases.
    Skip short tokens, all-caps tokens, and anything in our tech dictionary.
    """
    lower = text.strip().lower()

    # Skip if it's a known technical term
    if lower in _TECH_NORM_LOWER:
        return text

    # Skip short tokens (acronyms, abbreviations)
    if len(text.strip()) <= 6:
        return text

    # Skip all-caps tokens (AWS, HTML, etc.)
    if text.strip().isupper():
        return text

    # Skip tokens containing numbers or dots (e.g. "Node.js", "React.js")
    if any(c in text for c in ['.', '/', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9']):
        return text

    try:
        from textblob import TextBlob
        corrected = str(TextBlob(text).correct())
        # Reject if TextBlob made things worse (common with domain terms)
        if fuzz.ratio(text.lower(), corrected.lower()) < 60:
            return text
        return corrected
    except Exception:
        return text


def standardize_terms(text):
    """Apply TECH_NORMALIZATION for exact + fuzzy match."""
    return normalize_tech_term(text)


def is_junk(text):
    for pattern in JUNK_PATTERNS:
        if re.match(pattern, text.lower()):
            return True
    return False


def is_email(text):
    email_pattern = re.compile(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
    return bool(email_pattern.match(text.strip()))


def is_url(text):
    return bool(re.search(r'https?://|www\.', text.lower()))


def standardize_gender(text):
    normalized = text.strip().lower()
    gender_map = {
        'm': 'Male',
        'male': 'Male',
        'man': 'Male',
        'f': 'Female',
        'female': 'Female',
        'woman': 'Female',
        'non-binary': 'Non-binary',
        'nonbinary': 'Non-binary',
        'nb': 'Non-binary',
        'other': 'Other',
        'prefer not to say': 'Prefer not to say',
        'prefer not say': 'Prefer not to say',
        'unknown': 'Unknown',
    }
    return gender_map.get(normalized)


def clean_text_value(value, column_name=None):
    raw_value = value

    if pd.isna(value):
        return raw_value, "Unknown"

    text = str(value)

    if text.lower() in ["", "na", "null", "undefined"]:
        return raw_value, "Unknown"

    text = remove_extra_spaces(text)
    text = remove_emojis(text)

    if column_name and 'gender' in column_name.lower():
        gender = standardize_gender(text)
        if gender:
            return raw_value, gender
        return raw_value, "INVALID"

    if column_name and 'email' in column_name.lower():
        if is_email(text):
            return raw_value, text.lower()
        return raw_value, "INVALID"

    if column_name and ('url' in column_name.lower() or 'link' in column_name.lower()):
        if is_url(text):
            return raw_value, text
        return raw_value, "INVALID"

    if is_email(text):
        return raw_value, text.lower()

    if is_url(text):
        return raw_value, text

    text = remove_special_characters(text)

    # For skill/interest columns: apply tech normalization on each token
    if column_name and any(kw in column_name.lower() for kw in ['skill', 'interest', 'technology', 'career', 'goal']):
        text = normalize_tech_term(text)
    else:
        text = normalize_text(text)
        text = standardize_terms(text)
        text = correct_spelling(text)

    if is_junk(text):
        return raw_value, "INVALID"

    return raw_value, text


def validate_age(age):
    try:
        age = int(age)
        if age < 0 or age > 120:
            return False
        return True
    except:
        return False


def _is_number_string(value):
    try:
        float(str(value).strip())
        return True
    except Exception:
        return False


def is_numeric_like_column(series):
    if pd.api.types.is_numeric_dtype(series):
        return True
    if series.dtype == object or pd.api.types.is_string_dtype(series):
        values = series.dropna().astype(str).str.strip()
        non_empty = values[values != ""]
        if non_empty.empty:
            return False
        return non_empty.map(_is_number_string).all()
    return False


def apply_cleaning(df, cleaning_plan=None):
    if cleaning_plan is None:
        cleaning_plan = {}

    cleaned = df.copy()
    audit_log = []  # Track (column, original, normalized) triples

    # Apply duplicate removal if requested
    if cleaning_plan.get("remove_duplicates", False):
        cleaned = cleaned.drop_duplicates()

    # Column-wise cleaning
    final_cols = {}
    for col in cleaned.columns:
        series = cleaned[col]

        # Handle Numeric-like columns
        if is_numeric_like_column(series):
            series = pd.to_numeric(series, errors='coerce')
            strategy = cleaning_plan.get("fill_missing_numeric")
            if strategy == "mean":
                series = series.fillna(series.mean())
            elif strategy == "median":
                series = series.fillna(series.median())
            elif strategy == "mode":
                mode_val = series.mode().iloc[0] if not series.mode().empty else 0
                series = series.fillna(mode_val)
            final_cols[col] = series
            continue

        # Handle Categorical/String columns
        if pd.api.types.is_string_dtype(series) or series.dtype == object:
            clean_values = []
            for value in series:
                original, clean = clean_text_value(value, column_name=col)
                audit_log.append({
                    "column": col,
                    "original_value": str(original),
                    "normalized_value": str(clean),
                })
                if cleaning_plan.get("standardize_text", True) is False:
                    if cleaning_plan.get("trim_spaces", True) and isinstance(clean, str):
                        clean = clean.strip()
                clean_values.append(clean)

            series = pd.Series(clean_values, index=cleaned.index)

            strategy = cleaning_plan.get("fill_missing_categorical")
            if strategy == "mode":
                valid_series = series[~series.astype(str).str.upper().isin({"UNKNOWN", "INVALID"})]
                if not valid_series.empty:
                    mode_val = valid_series.mode().iloc[0]
                    series = series.replace(["Unknown", "UNKNOWN", "INVALID"], mode_val)

            final_cols[col] = series
        else:
            final_cols[col] = series

    cleaned = pd.DataFrame(final_cols)

    # Apply post-clean tech normalization to interest/skill columns
    for col in cleaned.columns:
        col_lower = col.lower()
        if any(kw in col_lower for kw in ['interest', 'skill', 'technology', 'career', 'goal']):
            cleaned[col] = cleaned[col].apply(
                lambda v: normalize_tech_term(str(v)) if pd.notna(v) and str(v).upper() not in {"UNKNOWN", "INVALID", "NAN"} else v
            )

    # Drop rows that are still marked as invalid/unknown
    invalid_mask = cleaned.apply(
        lambda col: col.astype(str).str.strip().str.upper().isin({"UNKNOWN", "INVALID"})
    )
    cleaned = cleaned[~invalid_mask.any(axis=1)]

    # Attach audit log to the dataframe as metadata for the exporter to retrieve
    cleaned.attrs['_audit_log'] = audit_log

    return cleaned.dropna()