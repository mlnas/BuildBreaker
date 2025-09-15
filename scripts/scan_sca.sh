#!/bin/sh

. ./scripts/common.sh

print_section "Software Composition Analysis"

require_cmd trivy

# Default thresholds if not set
SCA_MAX_HIGH=${SCA_MAX_HIGH:-0}

# Run Trivy filesystem scan
trivy fs --quiet --format json --output artifacts/trivy_sca.json app/

# Count high and critical vulnerabilities
high_crit_count=$(cat artifacts/trivy_sca.json | jq -r '.Results[]?.Vulnerabilities[]? | select(.Severity == "HIGH" or .Severity == "CRITICAL") | .Severity' | wc -l | tr -d ' ')

echo "Found HIGH/CRITICAL vulnerabilities: $high_crit_count (threshold: $SCA_MAX_HIGH)"

if [ "$high_crit_count" -gt "$SCA_MAX_HIGH" ]; then
  echo "❌ SCA check failed - too many HIGH/CRITICAL vulnerabilities"
  exit 1
else
  echo "✅ SCA check passed"
  exit 0
fi
