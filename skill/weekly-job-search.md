# Skill: Weekly Job Search Automation

This file is the Claude scheduled task prompt that drives the weekly job search pipeline.
It is saved here so the automation logic is version-controlled alongside the criteria it references.

---

## Scheduled Task Prompt

```
Please run my weekly job search automation:

1. Read job-criteria.md and scoring-rubric.md from the project folder
2. Search for new jobs using the Indeed connector based on my criteria
3. For each job found:
   - Extract key details (role, company, salary, requirements, etc.)
   - Research the company using available data
   - Score against my rubric (1-10 scale)
   - Flag any deal-breakers
4. Create a ranked shortlist of top opportunities (score 7+)
5. For the top 3 jobs, draft personalized cover letter outlines using my resume
6. Save results as "results/weekly-results-[DATE].md" in the project folder

Focus on quality over quantity — 5 great matches over 50 mediocre ones.
```

---

## Configuration

- **Schedule:** Weekly (Mondays or configured in Claude Cowork)
- **Connector required:** Indeed MCP connector
- **Input files:** `job-criteria.md`, `scoring-rubric.md`, resume (local, gitignored)
- **Output:** `results/weekly-results-YYYY-MM-DD.md`

---

## Notes on Tuning

- To adjust what gets surfaced, edit the search keywords in `job-criteria.md` (Target Roles section)
- To change scoring weights, edit `scoring-rubric.md`
- The rubric threshold for shortlisting is 7.0 — lower it to see more results, raise it to tighten the filter
- Deal-breakers in the rubric are hard stops — they override any score
