#!/bin/sh

. ./scripts/common.sh

print_section "Image Signature Verification"

# Check for simulated signature
if [ -f "artifacts/signed.ok" ]; then
  echo "✅ Image signature verified (simulation)"
  exit 0
else
  echo "❌ Image signature verification failed"
  echo "To simulate signing: touch artifacts/signed.ok"
  exit 1
fi
