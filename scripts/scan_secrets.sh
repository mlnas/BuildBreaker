#!/bin/sh

. ./scripts/common.sh

print_section "Secrets Scanning"

# Simple pattern-based secrets scanning
scan_patterns() {
  found_secrets=0
  patterns="AKIA[0-9A-Z]{16}|-----BEGIN.*PRIVATE KEY-----|password=|secret=|token=|sk-[0-9a-f]{32}|admin123"
  
  # Search for patterns in all files except those in .git, node_modules, and scripts
  results=$(find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -not -path "*/scripts/*" -exec grep -l -E "$patterns" {} \;)
  
  if [ -n "$results" ]; then
    echo "❌ Found potential secrets in:"
    echo "$results"
    found_secrets=1
  else
    echo "✅ No secrets found"
  fi
  
  return $found_secrets
}

# Try git-secrets if available, otherwise fall back to pattern scanning
if command -v git-secrets >/dev/null 2>&1; then
  git-secrets --scan
  exit $?
else
  scan_patterns
  exit $?
fi
