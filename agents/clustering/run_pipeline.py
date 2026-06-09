import os
import sys
from pathlib import Path

# Ensure the 'app' module can be found
sys.path.append(str(Path(__file__).parent))

from app.services.orchestrator import run_agent3_pipeline

if __name__ == "__main__":
    print("Triggering Clustering Agent Pipeline...")
    try:
        # We don't pass an input path, so it uses the default from config
        # (which is ../outputs/final_clean_dataset.xlsx)
        result = run_agent3_pipeline()
        print("Clustering pipeline complete!")
    except Exception as e:
        print(f"Error running clustering pipeline: {e}")
        sys.exit(1)
