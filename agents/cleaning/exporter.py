# -*- coding: utf-8 -*-
import os
import shutil
from datetime import datetime
from pathlib import Path

import pandas as pd
import requests

from dotenv import load_dotenv

load_dotenv()


def export_excel(df):
    """Export cleaned DataFrame atomically, generate a cleaning audit log,
    copy to Agent 3 inputs, and notify Agent 3 webhook (non-blocking).
    Excel is the single source of truth — no database persistence.
    """
    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    outputs_dir = Path("outputs")
    outputs_dir.mkdir(parents=True, exist_ok=True)

    # ── 1. Export main cleaned dataset ──────────────────────────────────
    tmp_file = outputs_dir / "final_clean_dataset.tmp.xlsx"
    final_file = outputs_dir / "final_clean_dataset.xlsx"

    df_export = df.copy()

    # Drop internal metadata attribute before export
    if '_audit_log' in df_export.attrs:
        del df_export.attrs['_audit_log']

    df_export.to_excel(tmp_file, index=False)
    tmp_file.replace(final_file)
    print(f"\n[SUCCESS] Clean Excel File Saved: {final_file}")

    # ── 2. Export cleaning audit log ────────────────────────────────────
    audit_log = df.attrs.get('_audit_log', [])
    if audit_log:
        audit_df = pd.DataFrame(audit_log, columns=["column", "original_value", "normalized_value"])
        # Only keep rows where a change actually occurred
        changed = audit_df[audit_df["original_value"].astype(str).str.strip() !=
                           audit_df["normalized_value"].astype(str).str.strip()]
        audit_file = outputs_dir / "cleaning_audit.xlsx"
        changed.to_excel(audit_file, index=False)
        print(f"[INFO] Cleaning Audit Log Saved: {audit_file}  ({len(changed)} changes recorded)")
    else:
        print("[INFO] No cleaning audit data available (audit log was not attached to DataFrame).")

    # ── 3. Copy to Agent 3 inputs dir ───────────────────────────────────
    agent3_inputs = Path(os.getenv("AGENT3_INPUT_DIR", "agent3-community-intelligence/inputs"))
    agent3_inputs.mkdir(parents=True, exist_ok=True)
    dest = agent3_inputs / "cleaned_data.xlsx"
    try:
        shutil.copy2(final_file, dest)
        print(f"[INFO] Copied cleaned file to Agent3 inputs: {dest}")
    except Exception as exc:
        print(f"[WARNING] failed to copy file to Agent3 inputs: {exc}")

    # ── 4. Notify Agent 3 webhook (non-blocking) ─────────────────────────
    notify_url = os.getenv("AGENT3_NOTIFY_URL", "http://127.0.0.1:8000/pipeline/run")
    notify_key = os.getenv("AGENT3_NOTIFY_KEY")
    payload = {"path": str(dest.resolve())}
    headers = {"Content-Type": "application/json"}
    if notify_key:
        headers[os.getenv("AGENT3_NOTIFY_HEADER", "X-Notify-Key")] = notify_key

    try:
        resp = requests.post(notify_url, json=payload, headers=headers, timeout=10)
        print(f"[INFO] Agent3 notified: {notify_url} → status {resp.status_code}")
    except requests.Timeout:
        print("[WARNING] Agent3 notify timed out (non-blocking).")
    except requests.ConnectionError:
        print("[WARNING] Agent3 not reachable (non-blocking).")
    except Exception as exc:
        print(f"[WARNING] unexpected error notifying Agent3: {exc}")

    return str(final_file)