# AI-Powered Job Search Automation

A weekly job search pipeline built with [Claude](https://claude.ai) (Cowork mode) that automatically searches Indeed, scores every listing against a personal rubric, and produces a ranked shortlist with cover letter outlines — all without manual effort.

---

## How It Works

Each week, Claude runs automatically and does the following:

1. **Reads the criteria** — pulls target roles, compensation expectations, remote requirements, and deal-breakers from `job-criteria.md`
2. **Searches Indeed** — runs multiple targeted keyword searches via the Indeed connector
3. **Scores every listing** — applies the weighted rubric in `scoring-rubric.md` (1–10 scale across 7 categories)
4. **Flags deal-breakers** — any role with no equity, no AI/LLM component, or required onsite work is auto-rejected
5. **Produces a shortlist** — only roles scoring 7.0+ make the cut
6. **Drafts cover letter outlines** — personalized outlines for the top 3 roles, grounded in the resume and the specific JD
7. **Saves a dated report** — `results/weekly-results-YYYY-MM-DD.md` is committed to this repo as a permanent log

---

## Repo Structure

```
job-search-automation/
├── README.md                          # This file
├── job-criteria.md                    # Target roles, compensation, location, deal-breakers
├── scoring-rubric.md                  # Weighted 7-category scoring system (1–10)
├── skill/
│   └── weekly-job-search.md          # The Claude scheduled task prompt that drives automation
└── results/
    └── weekly-results-YYYY-MM-DD.md  # Weekly scored shortlists (one per run)
```

---

## Scoring System

Every job is scored across 7 weighted categories:

| Category | Weight |
|---|---|
| AI/LLM Technical Match | 25% |
| Compensation | 20% |
| Remote Work | 15% |
| Company Stage & Equity Upside | 15% |
| Industry Alignment (EdTech / Fintech) | 10% |
| Tech Stack Match | 10% |
| Cultural Fit | 5% |

**Thresholds:**
- 8.5–10.0 → Top Priority (apply immediately)
- 7.0–8.4 → Strong Match (apply with personalized materials)
- 5.5–6.9 → Possible (only if pipeline is thin)
- Below 5.5 → Skip

Any role triggering a deal-breaker (no equity, no AI/LLM, required onsite, legacy stack, defense/gov) is auto-rejected with score = 0, regardless of other factors.

---

## Weekly Results Log

Each run produces a Markdown report committed to `results/`. The reports include:

- Full scored shortlist with per-category breakdowns
- Company research summaries (culture, ratings, stage)
- Deal-breaker flags and rejection log
- Personalized cover letter outlines for the top 3 roles
- Recommended actions for the week

| Date | Top Pick | Score |
|---|---|---|
| [2026-05-26](results/weekly-results-2026-05-26.md) | You.com — Senior Back End Engineer | 8.0 |

---

## Setup & Replication

This automation runs inside **Claude Cowork** with the Indeed MCP connector enabled. To replicate:

1. Copy `job-criteria.md` and `scoring-rubric.md` — update them to reflect your own target roles and preferences
2. In Claude Cowork, create a scheduled task pointing at `skill/weekly-job-search.md`
3. Make sure the **Indeed** connector is connected in your Cowork plugins
4. Point the task at your version of this folder

The criteria and rubric files are the only things you need to customize — Claude handles the rest.

---

## Stack

- **Automation:** Claude (Anthropic) via Cowork scheduled tasks
- **Job data:** Indeed MCP connector
- **Company research:** Indeed company knowledge base
- **Output format:** Markdown (human-readable, version-controlled)
- **No code required** — the entire pipeline is prompt-driven
