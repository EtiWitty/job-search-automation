#!/usr/bin/env bash
# Usage: ./scripts/new-week.sh [YYYY-MM-DD]
# Creates a branch for this week's results, stages the new results file, and opens a draft PR.
# If no date is given, today's date is used.

set -e

DATE="${1:-$(date +%Y-%m-%d)}"
BRANCH="weekly-results-${DATE}"
RESULTS_FILE="results/weekly-results-${DATE}.md"

cd "$(git rev-parse --show-toplevel)"

if [ ! -f "$RESULTS_FILE" ]; then
  echo "Error: $RESULTS_FILE not found. Run the Claude automation first, then run this script."
  exit 1
fi

git checkout main && git pull origin main
git checkout -b "$BRANCH"
git add "$RESULTS_FILE"
git commit -m "Weekly results: ${DATE}"
git push -u origin "$BRANCH"

gh pr create \
  --title "Weekly job search results: ${DATE}" \
  --body "$(cat .github/pull_request_template.md | sed "s/YYYY-MM-DD/${DATE}/g")" \
  --draft

echo ""
echo "Draft PR created for ${DATE}. Fill in the summary, check off actions, then mark ready for review."
