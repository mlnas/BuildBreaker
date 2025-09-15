#!/bin/sh

. ./scripts/common.sh

print_section "SAST Analysis"

require_cmd semgrep

# Default thresholds if not set
SAST_MAX_HIGH=${SAST_MAX_HIGH:-0}
SAST_MAX_MEDIUM=${SAST_MAX_MEDIUM:-2}

# Run Semgrep analysis
semgrep --config=.semgrep.yml --error --json --output artifacts/semgrep.json app/

# Count findings by severity
if command -v jq >/dev/null 2>&1; then
  high_count=$(cat artifacts/semgrep.json | jq -r '.results[] | select(.extra.severity == "ERROR") | .extra.severity' | wc -l | tr -d ' ')
  medium_count=$(cat artifacts/semgrep.json | jq -r '.results[] | select(.extra.severity == "WARNING") | .extra.severity' | wc -l | tr -d ' ')
else
  high_count=$(cat artifacts/semgrep.json | grep -c '"severity": "ERROR"' || echo 0)
  medium_count=$(cat artifacts/semgrep.json | grep -c '"severity": "WARNING"' || echo 0)
fi

echo "Found vulnerabilities:"
echo "High: $high_count (threshold: $SAST_MAX_HIGH)"
echo "Medium: $medium_count (threshold: $SAST_MAX_MEDIUM)"

# Check against thresholds
if [ "$high_count" -gt "$SAST_MAX_HIGH" ] || [ "$medium_count" -gt "$SAST_MAX_MEDIUM" ]; then
  echo "❌ SAST check failed - too many vulnerabilities"
  exit 1
else
  echo "✅ SAST check passed"
  exit 0
fi
