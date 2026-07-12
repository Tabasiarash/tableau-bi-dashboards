[![CI](https://github.com/Tabasiarash/tableau-bi-dashboards/actions/workflows/ci.yml/badge.svg)](https://github.com/Tabasiarash/tableau-bi-dashboards/actions/workflows/ci.yml)

# Tableau BI Dashboards

Data preparation and documentation for two Tableau Public dashboards: Olist Executive Overview (Brazil e-commerce) and HR Attrition Analysis.

## Status

Active

## Features

- Flattened Olist summary export (114,092 orders, 12 columns, 27 Brazilian states, 74 product categories)
- HR attrition dataset (1,470 employees, 35 features) ready for Tableau
- PostgreSQL-to-CSV ETL pipeline via Python

## Architecture

SQL query → Python ETL → CSV → Tableau Public dashboard

```
olist PostgreSQL DB ──> export_olist_summary.sql ──> export_olist_summary.py ──> olist_executive_summary.csv ──> Tableau Public
```

## Requirements

- Python 3.10+
- PostgreSQL 16+ (for Olist data)
- pandas, sqlalchemy, psycopg2

## Setup

```bash
git clone https://github.com/Tabasiarash/tableau-bi-dashboards.git
cd tableau-bi-dashboards
pip install pandas sqlalchemy psycopg2-binary
# Load Olist database (see olist-ecommerce repository for DB restore instructions)
python data_prep/export_olist_summary.py
# Open CSVs in data/ with Tableau Public
```

## Configuration

Hardcoded `DB_URL` in `data_prep/export_olist_summary.py` — should be externalized to an environment variable. See `.env.example`.

## Usage

- **Tableau Public**: Connect to CSVs under `data/` and build dashboards.
- **Python**: Run `python data_prep/export_olist_summary.py` to refresh Olist data from PostgreSQL.

## Development

- Add new SQL metrics to `data_prep/export_olist_summary.sql`.
- Add new data sources (CSV files) under `data/`.
- After adding new fields, rebuild the CSV and update the Tableau workbook.

## Known Limitations

- Hardcoded database credentials in `export_olist_summary.py`
- No `requirements.txt` (install dependencies manually)
- `screenshots/` placeholder directory not yet populated
- Tableau dashboards not yet published to Tableau Public

## License

MIT