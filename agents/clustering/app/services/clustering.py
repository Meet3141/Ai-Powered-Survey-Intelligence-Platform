from __future__ import annotations

from collections import Counter, defaultdict
from dataclasses import dataclass
from typing import Any

import numpy as np
import pandas as pd
import logging
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score

logger = logging.getLogger(__name__)

try:
    import hdbscan
except Exception:  # pragma: no cover - optional dependency fallback
    hdbscan = None


# ============================================================
# CANONICAL TAXONOMY
# Maps raw signal tokens → canonical community name + description
# ============================================================
CANONICAL_TAXONOMY: list[tuple[set[str], str, str]] = [
    (
        {
            "ai", "artificial intelligence", "machine learning", "ml", "deep learning",
            "data science", "tensorflow", "pytorch", "keras", "scikit-learn", "nlp",
            "natural language processing", "computer vision", "reinforcement learning",
            "ai/ml", "numpy", "pandas", "matplotlib", "neural network", "llm",
            "generative ai", "data analysis", "data analytics", "statistics",
        },
        "AI & Machine Learning Community",
        "Students focused on artificial intelligence, machine learning, and data-driven innovation.",
    ),
    (
        {
            "web development", "frontend", "backend", "full stack", "react", "react.js",
            "node.js", "javascript", "typescript", "html", "css", "html/css", "angular",
            "vue.js", "next.js", "express.js", "django", "flask", "php", "rest api",
            "graphql", "web design", "ui/ux", "ux", "ui", "web app",
        },
        "Web Development Community",
        "Students building modern web applications, APIs, and user-facing digital products.",
    ),
    (
        {
            "cloud computing", "aws", "azure", "google cloud", "gcp", "devops",
            "ci/cd", "docker", "kubernetes", "terraform", "linux", "networking",
            "system administration", "infrastructure", "microservices", "serverless",
        },
        "Cloud & DevOps Community",
        "Students mastering cloud platforms, infrastructure, and modern deployment pipelines.",
    ),
    (
        {
            "cybersecurity", "information security", "penetration testing", "ethical hacking",
            "network security", "cryptography", "ctf", "security", "forensics",
            "vulnerability", "malware analysis", "soc", "siem", "firewall",
        },
        "Cyber Security Community",
        "Students focused on digital security, ethical hacking, and protecting critical infrastructure.",
    ),
    (
        {
            "iot", "internet of things", "arduino", "raspberry pi", "embedded systems",
            "embedded", "robotics", "mechatronics", "hardware", "fpga",
            "microcontroller", "sensors", "automation", "control systems",
        },
        "Robotics & IoT Community",
        "Students innovating at the intersection of hardware, embedded systems, and connected devices.",
    ),
    (
        {
            "entrepreneurship", "startup", "business", "product management",
            "project management", "marketing", "finance", "economics",
            "business analytics", "venture", "innovation", "leadership",
            "e-commerce", "social enterprise", "pitching",
        },
        "Entrepreneurship Community",
        "Students building businesses, developing products, and driving innovation.",
    ),
    (
        {
            "mobile", "android", "ios", "flutter", "react native", "mobile development",
            "kotlin", "swift", "mobile app",
        },
        "Mobile Development Community",
        "Students focused on building native and cross-platform mobile applications.",
    ),
    (
        {
            "blockchain", "web3", "cryptocurrency", "smart contracts", "defi",
            "nft", "ethereum", "solidity",
        },
        "Blockchain & Web3 Community",
        "Students exploring decentralized technologies and the future of digital finance.",
    ),
    (
        {
            "game development", "game design", "unity", "unreal engine", "gaming",
            "esports", "simulation", "3d modeling", "vr", "ar", "ar/vr",
            "augmented reality", "virtual reality",
        },
        "Game Development & XR Community",
        "Students building games, interactive experiences, and extended reality applications.",
    ),
    (
        {
            "design", "graphic design", "ui/ux", "ux design", "ui design", "photography",
            "animation", "3d art", "video editing", "creative", "motion design",
        },
        "Creative & Design Community",
        "Students focused on visual design, creative media, and user experience craft.",
    ),
]

# Build reverse lookup: token → canonical name
_TOKEN_TO_COMMUNITY: dict[str, str] = {}
_TOKEN_TO_DESCRIPTION: dict[str, str] = {}
for _keywords, _name, _desc in CANONICAL_TAXONOMY:
    for _kw in _keywords:
        _TOKEN_TO_COMMUNITY[_kw.lower()] = _name
        _TOKEN_TO_DESCRIPTION[_kw.lower()] = _desc


# ============================================================
# THEME-SPECIFIC FACULTY RECOMMENDATIONS
# ============================================================
COMMUNITY_RECOMMENDATIONS: dict[str, list[str]] = {
    "AI & Machine Learning Community": [
        "Create an AI Research Lab with GPU compute access for student projects.",
        "Launch a Kaggle Competition Club with weekly leaderboard challenges.",
        "Organize a semester-long ML Hackathon focused on real-world datasets.",
        "Invite industry AI engineers for guest lectures and mentorship.",
        "Establish an undergraduate AI paper reading group.",
    ],
    "Web Development Community": [
        "Launch a Web Development Bootcamp for beginner-to-intermediate skill building.",
        "Organize a portfolio-building sprint and public demo day.",
        "Create an open-source project repository for collaborative contribution.",
        "Partner with local startups for live client project experience.",
        "Host a UI/UX Design Challenge judged by industry professionals.",
    ],
    "Cloud & DevOps Community": [
        "Offer AWS/Azure/GCP cloud certification preparation workshops.",
        "Build a student-operated Kubernetes cluster for hands-on DevOps practice.",
        "Organize a 'Ship to Production' challenge for deploying live applications.",
        "Partner with cloud providers for student credit programs.",
        "Launch a DevOps mentorship pairing students with industry practitioners.",
    ],
    "Cyber Security Community": [
        "Conduct a Capture the Flag (CTF) Competition each semester.",
        "Launch a Security Research Group focused on vulnerability disclosure.",
        "Organize ethical hacking workshops in a controlled lab environment.",
        "Establish partnerships with cybersecurity firms for internship pipelines.",
        "Build a campus Bug Bounty program to secure institutional systems.",
    ],
    "Robotics & IoT Community": [
        "Build a Robotics Innovation Lab with 3D printing and hardware prototyping tools.",
        "Participate in national robotics competitions (RoboSub, FIRST, etc.).",
        "Launch an IoT Smart Campus project applying student prototypes to real problems.",
        "Partner with electronics suppliers for component sponsorships.",
        "Organize a Hardware Hackathon with industry judges and prizes.",
    ],
    "Entrepreneurship Community": [
        "Launch a Startup Incubator with faculty mentors and seed funding.",
        "Organize a Product Pitch Competition with investor panel judges.",
        "Create a cross-disciplinary team formation event to spark venture ideas.",
        "Connect students with local entrepreneurship ecosystems and angel networks.",
        "Introduce a Lean Startup workshop series covering ideation to MVP.",
    ],
    "Mobile Development Community": [
        "Organize an App-a-thon where students build and publish real mobile apps.",
        "Establish a Mobile Dev Guild for knowledge sharing and code reviews.",
        "Partner with app stores for student developer account access.",
        "Launch a Mobile UX workshop series focused on accessibility and design.",
        "Host an App Demo Day for students to showcase published applications.",
    ],
    "Blockchain & Web3 Community": [
        "Launch a Blockchain Study Group covering DeFi, NFTs, and smart contracts.",
        "Organize a Web3 Hackathon with real blockchain deployment challenges.",
        "Partner with crypto companies for internship and mentorship pipelines.",
        "Build a campus tokenized reward system as a learning project.",
        "Invite Web3 founders for panel discussions on decentralized technology careers.",
    ],
    "Game Development & XR Community": [
        "Launch a Game Jam competition with theme-based 48-hour challenges.",
        "Build a dedicated XR lab with VR/AR headsets for prototyping.",
        "Partner with game studios for mentorship and internship pathways.",
        "Organize a public Game Showcase event for student-built games.",
        "Introduce a Game Design course covering narrative, mechanics, and UX.",
    ],
    "Creative & Design Community": [
        "Launch a Design Sprint series solving real campus user experience challenges.",
        "Organize a Student Portfolio Showcase and industry critique session.",
        "Partner with design agencies for freelance project pipelines.",
        "Introduce UX research methodologies as a supplementary workshop.",
        "Build a Creative Commons resource library for student design assets.",
    ],
}

# Default recs for unmapped communities
_DEFAULT_RECOMMENDATIONS = [
    "Establish a faculty mentorship program for this community.",
    "Organize a community showcase event to highlight student projects.",
    "Encourage interdisciplinary collaboration through cross-community events.",
    "Partner with industry professionals for guest speaker series.",
    "Launch a peer learning group with weekly study sessions.",
]


# ============================================================
# COMMUNITY DATACLASS
# ============================================================
@dataclass
class CommunityBundle:
    communities: list[dict[str, Any]]
    memberships: list[dict[str, Any]]
    student_community_map: dict[str, list[str]]
    clustering_method: str


# ============================================================
# LABEL NORMALIZATION
# ============================================================
def normalize_label(token: str) -> str | None:
    """Map a raw signal token to its canonical community name, if known."""
    return _TOKEN_TO_COMMUNITY.get(token.lower().strip())


def canonical_community_name_from_signals(signals: set[str]) -> tuple[str, str] | tuple[None, None]:
    """
    Given a set of signal tokens, return the best-matching canonical
    community name and description by counting votes across all tokens.
    Returns (None, None) if no match found.
    """
    votes: Counter[str] = Counter()
    for signal in signals:
        canonical = normalize_label(signal)
        if canonical:
            votes[canonical] += 1
    if not votes:
        return None, None
    best_name = votes.most_common(1)[0][0]
    # Find description from taxonomy
    for keywords, name, desc in CANONICAL_TAXONOMY:
        if name == best_name:
            return best_name, desc
    return best_name, f"Community of students focused on {best_name.replace(' Community', '')}."


def _community_health_score(member_count: int, interest_diversity: int, skill_diversity: int) -> int:
    """
    Compute a 0–100 health score for a community.
    - Size contribution (40 pts): score based on member count (10+ = full marks)
    - Interest diversity (30 pts): number of unique interests / 5
    - Skill diversity (30 pts): number of unique skills / 5
    """
    size_score = min(40, int((member_count / 10) * 40))
    interest_score = min(30, int((interest_diversity / 5) * 30))
    skill_score = min(30, int((skill_diversity / 5) * 30))
    return size_score + interest_score + skill_score


# ============================================================
# EMBEDDING GENERATION
# Lightweight TF-IDF + SVD embeddings — no model download,
# no HuggingFace dependency, runs instantly on any server.
# ============================================================
def generate_embeddings(texts: list[str], model_name: str) -> np.ndarray:
    """
    Generate dense embeddings using TF-IDF + TruncatedSVD (LSA).
    This is a zero-download alternative to sentence-transformers that works
    reliably on free-tier cloud instances (Render/Railway) without OOM or timeout.
    model_name is accepted but ignored (kept for API compatibility).
    """
    from sklearn.feature_extraction.text import TfidfVectorizer
    from sklearn.decomposition import TruncatedSVD
    from sklearn.preprocessing import normalize

    if not texts:
        return np.empty((0, 64), dtype=np.float32)

    n = len(texts)
    # Cap SVD components to a sensible range
    n_components = min(64, n - 1) if n > 1 else 1

    vectorizer = TfidfVectorizer(
        ngram_range=(1, 2),
        max_features=5000,
        sublinear_tf=True,
        min_df=1,
    )
    tfidf_matrix = vectorizer.fit_transform(texts)

    if n_components >= 1 and tfidf_matrix.shape[1] > n_components:
        svd = TruncatedSVD(n_components=n_components, random_state=42)
        embeddings = svd.fit_transform(tfidf_matrix)
    else:
        embeddings = tfidf_matrix.toarray()

    # L2-normalize so cosine similarity == dot product
    embeddings = normalize(embeddings, norm="l2")
    return embeddings.astype(np.float32)


# ============================================================
# CLUSTERING ALGORITHMS
# ============================================================
def _run_hdbscan(embeddings: np.ndarray) -> np.ndarray:
    if hdbscan is None:
        raise RuntimeError("hdbscan is unavailable")
    if len(embeddings) < 3:
        raise RuntimeError("not enough rows for hdbscan")
    min_cluster_size = max(2, min(5, len(embeddings) // 3))
    clusterer = hdbscan.HDBSCAN(min_cluster_size=min_cluster_size, metric="euclidean")
    return clusterer.fit_predict(embeddings)


def _dataset_aware_k_bounds(n: int) -> tuple[int, int]:
    """Return (min_k, max_k) based on dataset size to prevent over/under-segmentation."""
    if n <= 50:
        return 3, 5
    elif n <= 100:
        return 4, 7
    else:
        return 4, min(12, n - 1)


def _merge_micro_clusters(labels: np.ndarray, embeddings: np.ndarray, min_size: int = 2) -> np.ndarray:
    """
    Merge any cluster with fewer than `min_size` members into the nearest cluster
    by computing the centroid distance.
    """
    labels = labels.copy()
    changed = True
    while changed:
        changed = False
        unique, counts = np.unique(labels[labels >= 0], return_counts=True)
        micro = unique[counts < min_size]
        if len(micro) == 0:
            break
        # Build centroids for non-micro clusters
        macro = unique[counts >= min_size]
        if len(macro) == 0:
            break
        centroids = {int(k): embeddings[labels == k].mean(axis=0) for k in macro}
        for micro_label in micro:
            micro_mask = labels == micro_label
            micro_centroid = embeddings[micro_mask].mean(axis=0)
            # Find nearest macro cluster centroid
            nearest = min(
                macro,
                key=lambda k: float(np.linalg.norm(micro_centroid - centroids[int(k)])),
            )
            labels[micro_mask] = nearest
            changed = True
    return labels


def _run_kmeans_optimal(embeddings: np.ndarray) -> tuple[np.ndarray, int, float]:
    n = len(embeddings)
    if n < 2:
        return np.zeros(n, dtype=int), 1, 0.0

    min_k, max_k = _dataset_aware_k_bounds(n)
    max_k = min(max_k, n - 1)

    if max_k < min_k:
        return np.zeros(n, dtype=int), 1, 0.0

    best_labels: np.ndarray | None = None
    best_k = min_k
    best_score = -1.0

    for k in range(min_k, max_k + 1):
        model = KMeans(n_clusters=k, n_init="auto", random_state=42)
        labels = model.fit_predict(embeddings)
        if len(set(labels)) > 1:
            score = silhouette_score(embeddings, labels)
            if score > best_score:
                best_score = score
                best_k = k
                best_labels = labels

    if best_labels is None:
        best_labels = np.zeros(n, dtype=int)
        best_k = 1
        best_score = 0.0

    # Merge micro-clusters (< 2 members)
    best_labels = _merge_micro_clusters(best_labels, embeddings, min_size=2)
    actual_k = len(set(best_labels[best_labels >= 0]))
    avg_size = n / max(actual_k, 1)

    logger.info(
        "[CLUSTERING] Students: %d | Clusters: %d | Silhouette: %.2f | Avg Size: %.1f",
        n, actual_k, best_score, avg_size,
    )
    print(
        f"\n[CLUSTERING] Students: {n} | Clusters: {actual_k} | "
        f"Silhouette: {best_score:.2f} | Avg Size: {avg_size:.1f}\n"
    )
    return best_labels, actual_k, best_score


def cluster_students(embeddings: np.ndarray) -> tuple[np.ndarray, int, str]:
    student_count = len(embeddings)
    if student_count == 0:
        return np.array([]), 0, "none"

    if student_count >= 100 and hdbscan is not None:
        try:
            labels = _run_hdbscan(embeddings)
            unique_labels = {int(label) for label in labels if int(label) >= 0}
            if len(unique_labels) >= 2:
                labels = _merge_micro_clusters(labels, embeddings)
                actual_k = len({int(l) for l in labels if int(l) >= 0})
                avg_size = student_count / max(actual_k, 1)
                logger.info(
                    "[CLUSTERING] Students: %d | Method: HDBSCAN | Clusters: %d | Avg Size: %.1f",
                    student_count, actual_k, avg_size,
                )
                return labels, actual_k, "hdbscan"
        except Exception:
            pass

    labels, k, score = _run_kmeans_optimal(embeddings)
    return labels, k, "kmeans"


# ============================================================
# COMMUNITY DISCOVERY
# ============================================================
def discover_communities(
    frame: pd.DataFrame,
    embeddings: np.ndarray,
    labels: np.ndarray,
    clustering_method: str,
) -> CommunityBundle:
    student_map: dict[str, list[str]] = defaultdict(list)
    community_rows: dict[str, dict[str, Any]] = {}
    memberships: list[dict[str, Any]] = []

    cluster_tokens: dict[str, Counter[str]] = defaultdict(Counter)
    cluster_members: dict[str, list[int]] = defaultdict(list)
    cluster_interests: dict[str, Counter[str]] = defaultdict(Counter)
    cluster_skills: dict[str, Counter[str]] = defaultdict(Counter)

    for index, label in enumerate(labels):
        if int(label) < 0:
            continue
        cluster_key = f"cluster-{int(label)}"
        cluster_members[cluster_key].append(index)
        cluster_tokens[cluster_key].update(frame.iloc[index]["signals"])

        interests = [part.strip().title() for part in str(frame.iloc[index].get("interests", "")).split(",") if part.strip()]
        skills = [part.strip().title() for part in str(frame.iloc[index].get("skill", "")).split(",") if part.strip()]
        cluster_interests[cluster_key].update(interests)
        cluster_skills[cluster_key].update(skills)

    for cluster_key, member_indexes in cluster_members.items():
        # ── Skip micro-clusters that survived merging (paranoid guard) ──
        if len(member_indexes) < 2:
            logger.warning("Discarding micro-cluster %s with %d member(s)", cluster_key, len(member_indexes))
            continue

        signals: set[str] = set()
        for idx in member_indexes:
            signals.update(frame.iloc[idx]["signals"])

        # Canonical name resolution via taxonomy
        canonical_name, canonical_desc = canonical_community_name_from_signals(signals)

        if canonical_name is None:
            # Fallback: use top tokens
            valid_tokens = [t for t, _ in cluster_tokens[cluster_key].most_common() if len(t) > 2]
            if valid_tokens:
                top = valid_tokens[0].title()
                canonical_name = f"{top} Community"
            else:
                canonical_name = f"Student Community {cluster_key.replace('cluster-', '')}"
            canonical_desc = f"A community of {len(member_indexes)} students with shared interests."

        c_interests = [t for t, _ in cluster_interests[cluster_key].most_common(5)]
        c_skills = [t for t, _ in cluster_skills[cluster_key].most_common(5)]
        reps = [str(frame.iloc[i].get("name", f"Student {i}")).title() for i in member_indexes[:3]]

        # Community-specific faculty actions
        faculty_actions = COMMUNITY_RECOMMENDATIONS.get(canonical_name, _DEFAULT_RECOMMENDATIONS)

        # Health score
        health = _community_health_score(
            member_count=len(member_indexes),
            interest_diversity=len(cluster_interests[cluster_key]),
            skill_diversity=len(cluster_skills[cluster_key]),
        )

        community_rows[cluster_key] = {
            "community_key": cluster_key,
            "name": canonical_name,
            "description": canonical_desc,
            "centroid": embeddings[member_indexes].mean(axis=0).tolist(),
            "size": len(member_indexes),
            "top_interests": c_interests,
            "top_skills": c_skills,
            "representative_students": reps,
            "faculty_recommendations": faculty_actions,  # kept for backwards compat
            "faculty_actions": faculty_actions,
            "community_health_score": health,
        }

    # Membership tracking
    for index, row in frame.iterrows():
        student_id = str(row["student_id"])
        if int(labels[index]) >= 0:
            cluster_key = f"cluster-{int(labels[index])}"
            # Only add if cluster survived the micro-cluster filter
            if cluster_key in community_rows:
                student_map[student_id].append(cluster_key)
                memberships.append(
                    {
                        "community_key": cluster_key,
                        "student_id": student_id,
                        "student_name": row["name"],
                        "department": row["department"],
                        "membership_weight": 1.0,
                    }
                )

    # ── Filter: discard any community with no members / no interests / no students ──
    valid_communities = []
    for comm in community_rows.values():
        if comm.get("size", 0) < 2:
            logger.warning("Filtering empty/micro community: %s (size=%d)", comm["name"], comm.get("size", 0))
            continue
        if not comm.get("representative_students"):
            logger.warning("Filtering community with no students: %s", comm["name"])
            continue
        valid_communities.append(comm)

    # Deduplicate by canonical name (multiple clusters may map to same theme)
    seen_names: dict[str, dict[str, Any]] = {}
    for comm in valid_communities:
        name = comm["name"]
        if name not in seen_names:
            seen_names[name] = comm
        else:
            # Merge: combine members, take best health score
            existing = seen_names[name]
            existing["size"] += comm["size"]
            existing["representative_students"] = list(dict.fromkeys(
                existing["representative_students"] + comm["representative_students"]
            ))[:5]
            existing["top_interests"] = list(dict.fromkeys(
                existing["top_interests"] + comm["top_interests"]
            ))[:5]
            existing["top_skills"] = list(dict.fromkeys(
                existing["top_skills"] + comm["top_skills"]
            ))[:5]
            existing["community_health_score"] = max(
                existing["community_health_score"], comm["community_health_score"]
            )

    communities = list(seen_names.values())

    for student_id in list(student_map.keys()):
        student_map[student_id] = sorted(dict.fromkeys(student_map[student_id]))

    return CommunityBundle(
        communities=communities,
        memberships=memberships,
        student_community_map=dict(student_map),
        clustering_method=clustering_method,
    )
