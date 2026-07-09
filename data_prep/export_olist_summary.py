#!/usr/bin/env python3
"""Export flattened Olist order summary CSV for Tableau Dashboard A.

Reads export_olist_summary.sql, runs it against the Olist PostgreSQL DB,
writes data/olist_executive_summary.csv.
"""

from __future__ import annotations

import logging
import subprocess
import sys
from pathlib import Path

import pandas as pd

logging.basicConfig(level=logging.INFO, format="%(asctime)s  %(message)s")
log = logging.getLogger("export_olist")

ROOT = Path(__file__).resolve().parent.parent
SQL_FILE = ROOT / "data_prep" / "export_olist_summary.sql"
CSV_OUT = ROOT / "data" / "olist_executive_summary.csv"
DB_URL = "postgresql://analyst:analyst_pass@localhost:5432/olist"


def main() -> None:
    if not SQL_FILE.exists():
        log.error("SQL file not found: %s", SQL_FILE)
        sys.exit(1)

    log.info("Reading SQL from %s", SQL_FILE)
    sql = SQL_FILE.read_text().strip()

    log.info("Querying Olist DB...")
    df = pd.read_sql(sql, DB_URL)

    log.info("Rows fetched: %s", f"{len(df):,}")
    log.info("Columns: %s", list(df.columns))
    log.info("Null counts:\n%s", df.isnull().sum().to_string())

    CSV_OUT.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(CSV_OUT, index=False)
    log.info("Written to %s  (%s rows, %s columns)",
             CSV_OUT, f"{len(df):,}", len(df.columns))


if __name__ == "__main__":
    main()
