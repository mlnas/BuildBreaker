#!/bin/sh

. ./scripts/common.sh

print_section "SBOM Generation"

require_cmd syft

# Generate SBOM in CycloneDX format
syft packages build-breaker:workshop -o cyclonedx-json > artifacts/sbom.json

echo "✅ SBOM generated at artifacts/sbom.json"
exit 0
