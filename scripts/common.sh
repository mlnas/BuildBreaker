#!/bin/sh

# Print a section header
print_section() {
  echo "\n=== $1 ===\n"
}

# Check if a command exists
require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Error: $1 is required but not installed."
    case "$1" in
      semgrep)
        echo "Install with: pip install semgrep"
        ;;
      trivy)
        echo "Install with: brew install trivy"
        ;;
      checkov)
        echo "Install with: pip install checkov"
        ;;
      syft)
        echo "Install with: brew install syft"
        ;;
      *)
        echo "Please install $1 to continue."
        ;;
    esac
    exit 1
  fi
}

# Create artifacts directory if it doesn't exist
mkdir -p artifacts
