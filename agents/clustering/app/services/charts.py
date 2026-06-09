from __future__ import annotations

import logging
from pathlib import Path
from typing import Any

import matplotlib

logger = logging.getLogger(__name__)

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np


FONT_SIZE = 10


def _ensure_output_dir(output_dir: str | Path) -> Path:
    path = Path(output_dir)
    path.mkdir(parents=True, exist_ok=True)
    return path


def _save_figure(fig: plt.Figure, output_path: Path) -> str:
    fig.tight_layout()
    fig.savefig(output_path, dpi=200, bbox_inches="tight")
    plt.close(fig)
    return str(output_path)


def _bar_chart(items: list[dict[str, Any]], title: str, output_path: Path) -> str:
    labels = [str(item["label"]) for item in items]
    counts = [int(item["count"]) for item in items]
    fig, ax = plt.subplots(figsize=(10, 6))
    ax.bar(labels, counts, color="#2563eb")
    ax.set_title(title)
    ax.tick_params(axis="x", rotation=35, labelsize=FONT_SIZE)
    ax.tick_params(axis="y", labelsize=FONT_SIZE)
    return _save_figure(fig, output_path)


def _pie_chart(items: list[dict[str, Any]], title: str, output_path: Path) -> str:
    labels = [str(item["label"]) for item in items]
    counts = [int(item["count"]) for item in items]
    fig, ax = plt.subplots(figsize=(8, 8))
    ax.pie(counts, labels=labels, autopct="%1.1f%%", startangle=140)
    ax.set_title(title)
    return _save_figure(fig, output_path)


def _heatmap(matrix: list[list[int]], row_labels: list[str], col_labels: list[str], title: str, output_path: Path) -> str:
    fig, ax = plt.subplots(figsize=(12, 8))
    heatmap = ax.imshow(matrix, cmap="Blues")
    ax.set_title(title)
    ax.set_xticks(range(len(col_labels)))
    ax.set_yticks(range(len(row_labels)))
    ax.set_xticklabels(col_labels, rotation=30, ha="right")
    ax.set_yticklabels(row_labels)
    fig.colorbar(heatmap, ax=ax)
    for row_index, row in enumerate(matrix):
        for col_index, value in enumerate(row):
            ax.text(col_index, row_index, str(value), ha="center", va="center", color="black", fontsize=8)
    return _save_figure(fig, output_path)


def generate_all_charts(metrics: dict[str, Any], output_dir: str | Path) -> dict[str, str]:
    path = _ensure_output_dir(output_dir)
    chart_paths: dict[str, str] = {}

    def _safe_pie(key: str, title: str, filename: str):
        data = metrics.get(key, [])
        if not data:
            logger.warning(f"Skipping chart '{title}': No data available for metric '{key}'")
            return
        chart_paths[key] = _pie_chart(data[:6], title, path / filename)

    def _safe_bar(key: str, title: str, filename: str):
        data = metrics.get(key, [])
        if not data:
            logger.warning(f"Skipping chart '{title}': No data available for metric '{key}'")
            return
        chart_paths[key] = _bar_chart(data[:10], title, path / filename)

    _safe_pie("interest_distribution", "Interest Distribution", "interest_distribution.png")
    _safe_pie("department_distribution", "Department Distribution", "department_distribution.png")
    _safe_pie("career_goal_distribution", "Career Goal Distribution", "career_goal_distribution.png")
    
    _safe_bar("skill_distribution", "Top Skills", "top_skills.png")
    _safe_bar("most_popular_technologies", "Top Technologies", "top_technologies.png")
    _safe_bar("community_size_analysis", "Community Sizes", "community_sizes.png")
    _safe_bar("most_requested_learning_topics", "Learning Preferences", "learning_preferences.png")

    department_interest = metrics.get("department_vs_interest", {})
    if department_interest:
        row_labels = list(department_interest.keys())[:8]
        col_counter = []
        top_interest_labels = []
        for department in row_labels:
            top_items = department_interest[department][:8]
            top_interest_labels = list(dict.fromkeys(top_interest_labels + [item["label"] for item in top_items]))
        matrix = []
        for department in row_labels:
            item_map = {item["label"]: int(item["count"]) for item in department_interest[department]}
            matrix.append([item_map.get(label, 0) for label in top_interest_labels[:8]])
        chart_paths["department_vs_interest"] = _heatmap(matrix, row_labels, top_interest_labels[:8], "Department vs Interest", path / "department_vs_interest.png")

    skill_career = metrics.get("skill_vs_career_goal", {})
    if skill_career:
        row_labels = list(skill_career.keys())[:8]
        top_goal_labels = []
        for skill in row_labels:
            top_items = skill_career[skill][:8]
            top_goal_labels = list(dict.fromkeys(top_goal_labels + [item["label"] for item in top_items]))
        matrix = []
        for skill in row_labels:
            item_map = {item["label"]: int(item["count"]) for item in skill_career[skill]}
            matrix.append([item_map.get(label, 0) for label in top_goal_labels[:8]])
        chart_paths["skill_vs_career_goal"] = _heatmap(matrix, row_labels, top_goal_labels[:8], "Skill vs Career Goal", path / "skill_vs_career_goal.png")

    return chart_paths
