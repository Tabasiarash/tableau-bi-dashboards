# AGENTS.md

## Architecture

```
tableau-bi-dashboards/
├── AGENTS.md                          # This file — agent context
├── CHANGELOG.md                       # Release history
├── LICENSE                            # MIT license
├── README.md                          # Project overview & setup
├── .env.example                       # Database URL template
├── data/
│   ├── olist_executive_summary.csv    # Flattened Olist orders (114k rows)
│   └── hr_attrition.csv               # IBM HR Analytics dataset (1,470 rows)
├── data_prep/
│   ├── export_olist_summary.sql       # Flattened query for Olist export
│   └── export_olist_summary.py        # PostgreSQL → CSV ETL script
└── screenshots/                       # Dashboard screenshots (TO BE ADDED)
```

## Conventions

| Layer | Convention |
|---|---|
| SQL | Write flat, denormalized queries for direct Tableau consumption (no in-tool joins) |
| Python | Use pandas for ETL; sqlalchemy + psycopg2 for DB connectivity |
| Data | Store final CSVs in `data/`; queries in `data_prep/` |
| Visualization | Build in Tableau Public; publish to web for sharing |

## Current State

| Layer | Status |
|---|---|
| Olist data prep | Built (`export_olist_summary.sql` + `.py` produce `data/olist_executive_summary.csv`) |
| HR data | Built (raw CSV from Kaggle placed in `data/`) |
| Tableau dashboards | Not yet published; no Tableau Public URLs |
| HR dashboard design | Not started |
| Screenshots | Not captured |

## Known Issues

- Hardcoded `DB_URL` in `data_prep/export_olist_summary.py` (`analyst/analyst_pass`) — must externalize to env var or secrets manager.
- No `requirements.txt` — dependencies listed in README but not pinned.

## Workflow Policy

1. **SQL first** — shape data at the query layer before Python transformation.
2. **ETL is idempotent** — re-running `export_olist_summary.py` overwrites the CSV.
3. **CSVs are the contract** — Tableau workbooks bind to `data/*.csv`; regenerate after schema changes.
4. **Commit messages** follow [Conventional Commits](https://www.conventionalcommits.org/).
5. **No secrets in code** — DB credentials must never be committed; use `.env` and `.gitignore`.
6. **No data in screenshots/** — only in `data/`; screenshots are purely documentary.
