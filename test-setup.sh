#!/bin/bash

echo "🔍 Testing Build-Breaker Challenge Setup"
echo "========================================"

# Test basic pipeline
echo -e "\n1. Testing basic pipeline..."
if make pass >/dev/null 2>&1; then
    echo "✅ Basic pipeline passes"
else
    echo "❌ Basic pipeline fails"
    exit 1
fi

# Test hardened pipeline (should fail without tools)
echo -e "\n2. Testing hardened pipeline (without tools)..."
if make fail >/dev/null 2>&1; then
    echo "❌ Hardened pipeline should fail without tools"
    exit 1
else
    echo "✅ Hardened pipeline fails as expected (tools not installed)"
fi

# Check for required tools
echo -e "\n3. Checking for security tools..."
tools=("semgrep" "checkov" "trivy" "syft" "docker")
missing_tools=()

for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✅ $tool is installed"
    else
        echo "❌ $tool is missing"
        missing_tools+=("$tool")
    fi
done

if [ ${#missing_tools[@]} -eq 0 ]; then
    echo -e "\n🎉 All tools are installed! You can run the full hardened pipeline."
    echo "Try: make fail"
else
    echo -e "\n📝 Missing tools: ${missing_tools[*]}"
    echo "Install with:"
    echo "  pip install semgrep checkov"
    echo "  brew install trivy syft"
    echo "  Start Docker Desktop (macOS) or systemctl start docker (Linux)"
fi

echo -e "\n✨ Setup test complete!"
