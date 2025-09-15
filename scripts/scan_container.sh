#!/bin/sh

. ./scripts/common.sh

print_section "Container Security Scanning"

require_cmd trivy

# Default thresholds if not set
IMG_MAX_HIGH=${IMG_MAX_HIGH:-0}

# Run Trivy container scan
trivy image --quiet --format json --output artifacts/trivy_image.json build-breaker:workshop

# Count high and critical vulnerabilities
high_crit_count=$(cat artifacts/trivy_image.json | jq -r '.Results[]?.Vulnerabilities[]? | select(.Severity == "HIGH" or .Severity == "CRITICAL") | .Severity' | wc -l | tr -d ' ')

echo "Found HIGH/CRITICAL vulnerabilities: $high_crit_count (threshold: $IMG_MAX_HIGH)"

if [ "$high_crit_count" -gt "$IMG_MAX_HIGH" ]; then
  echo "❌ Container scan failed - too many HIGH/CRITICAL vulnerabilities"
  exit 1
else
  echo "✅ Container scan passed"
  exit 0
fi
