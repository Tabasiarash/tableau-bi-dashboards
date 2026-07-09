# Tableau Public Dashboards

Data preparation and documentation for two Tableau Public dashboards — one
analysing Olist e-commerce operations across Brazil, another exploring employee
attrition drivers in a corporate HR dataset. Demonstrates range across domains
and BI tools (Tableau Public for visual discovery vs. Metabase for
operational dashboards; see [ecommerce-sales-intelligence](https://github.com/Tabasiarash/ecommerce-sales-intelligence)).

---

## Dashboard A — Olist Executive Overview

**Business question:** Where is revenue coming from, how fast are we delivering,
and which product categories drive the most value?

A flat order-level export from the Olist PostgreSQL database (114,092 orders,
Sep 2016–Oct 2018, 27 Brazilian states, 74 product categories) designed for
drag-and-drop use in Tableau without any in-tool joins.

**Key views (to be built in Tableau):**
- Brazil map: revenue by state (bubble or filled map)
- Top product categories by revenue and volume
- Monthly revenue trend with forecast
- Delivery performance: delay distribution, on-time rate by state
- Review score vs. delivery delay scatter

**Data source:** Olist PostgreSQL DB, flattened via `data_prep/export_olist_summary.sql`

| Field | Description |
|---|---|
| order_id | Unique order identifier |
| order_date | Purchase timestamp (date) |
| customer_state | 2-letter state code (27 states) |
| customer_city | City name |
| product_category | Product category (74 categories) |
| price | Item price (BRL) |
| freight_value | Shipping cost (BRL) |
| total_order_value | price + freight |
| delivery_delay_days | Actual vs. estimated delivery (negative = early) |
| delivery_time_days | Order-to-delivery duration |
| review_score | 1–5 customer rating |
| order_status | delivery status |

---

## Dashboard B — HR Attrition Analysis

**Business question:** What drives employee attrition, and which departments
or roles are most at risk?

The IBM HR Analytics dataset (1,470 employees, 35 features) covers demographics,
job role, satisfaction scores, compensation, and tenure. Small enough to explore
interactively in Tableau without performance concerns.

**Key views (to be built in Tableau):**
- Overall attrition rate (16.1%) and key driver matrix
- Attrition by department and job role
- Salary band vs. attrition (MonthlyIncome distributions)
- Tenure and promotion history vs. attrition
- Overtime, work-life balance, and satisfaction score breakdowns

**Data source:** Kaggle — [IBM HR Analytics Employee Attrition & Performance](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)

| Key Fields | Description |
|---|---|
| Attrition | Target (Yes/No) — 16.1% rate |
| Department | Sales, Research & Development, Human Resources |
| JobRole | 9 distinct roles |
| MonthlyIncome | Monthly salary (BRL-equivalent) |
| TotalWorkingYears | Years of professional experience |
| YearsAtCompany | Tenure with current employer |
| OverTime | Yes/No |
| JobSatisfaction | 1 (low) – 4 (high) |
| WorkLifeBalance | 1 (bad) – 4 (good) |

---

## TODO: Dashboard Screenshots

*Screenshots will be added here after the dashboards are built and published on
Tableau Public.*

---

## TODO: Live Tableau Public Links

- **Dashboard A — Olist Executive Overview:** `[URL to be added after publishing]`
- **Dashboard B — HR Attrition Analysis:** `[URL to be added after publishing]`

---

## Tech Stack

- **BI tool:** Tableau Public (desktop build, web publishing)
- **Data prep:** PostgreSQL 16, Python (pandas, sqlalchemy, psycopg2)
- **Data sources:** Olist e-commerce (custom export), IBM HR Analytics (Kaggle)

## Project Structure

```
tableau-bi-dashboards/
├── README.md
├── data/
│   ├── olist_executive_summary.csv    # 114,092 rows, 12 columns
│   └── hr_attrition.csv               # 1,470 rows, 35 columns
├── data_prep/
│   ├── export_olist_summary.sql         # Flattened query for Tableau
│   └── export_olist_summary.py          # Export script (PostgreSQL → CSV)
└── screenshots/                         # (to be added after publishing)
```
