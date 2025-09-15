#!/bin/sh

. ./scripts/common.sh

print_section "Infrastructure as Code Scanning"

require_cmd checkov

# Run Checkov scan
checkov -d iac/ -o json > artifacts/checkov.json

# Check if any checks failed (excluding skipped)
failed_count=$(cat artifacts/checkov.json | grep -c '"result": "FAILED"' || echo 0)

echo "Found failed checks: $failed_count"

if [ "$failed_count" -gt 0 ]; then
  echo "❌ IaC check failed - security misconfigurations found"
  checkov -d iac/ --compact
  exit 1
else
  echo "✅ IaC check passed"
  exit 0
fi
