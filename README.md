# Build-Breaker Challenge

A hands-on workshop for implementing security gates in Bitbucket Pipelines. This repo contains a deliberately vulnerable application and infrastructure code to practice implementing and fixing security controls.

## 🎯 Challenge

You're enabling security gates in Bitbucket Pipelines. The default branch passes with minimal checks. Your task is to:

1. Create a `hardened/yourname` branch
2. Enable the hardened security gates
3. Fix the security issues to get a green build

## 🚀 Quick Start

```bash
# Setup local tools
make setup

# Install security tools (required for hardened pipeline)
pip install semgrep checkov
brew install trivy syft

# Start Docker (required for container scanning)
# On macOS: Start Docker Desktop
# On Linux: sudo systemctl start docker

# Run basic pipeline (should pass)
make pass

# Run hardened pipeline (should fail initially)
make fail
```

## 🔍 Security Gates

The hardened pipeline implements these security checks:

1. **Secrets Scanning**: Detect hardcoded credentials and sensitive data
2. **SAST**: Static analysis for code vulnerabilities
3. **SCA**: Software composition analysis for dependency vulnerabilities
4. **IaC Scanning**: Infrastructure-as-Code security checks
5. **Container Scanning**: Docker image vulnerability analysis
6. **SBOM**: Software Bill of Materials generation
7. **Image Signing**: Simulated container image signature verification

## 🛠️ Known Issues to Fix

### Application (app/)
- SQL injection risk in query building
- SSRF vulnerability in URL fetching
- Weak cryptographic hash (MD5)
- Outdated dependency with known vulnerabilities

### Infrastructure (iac/)
- Open SSH access (0.0.0.0/0)
- Public S3 bucket configuration

### Container (app/Dockerfile)
- Base image with known vulnerabilities
- Running as root user

## 🎓 Workshop Flow

1. Clone this repo
2. Create branch: `git checkout -b hardened/yourname`
3. Run `make fail` to see initial failures
4. Fix the issues one by one
5. Re-run `make fail` until all checks pass

## 📊 Scoring Rubric

| Task | Points |
|------|---------|
| Make pipeline fail on first run | 3 pts |
| Fix app SAST & SCA issues | 5 pts |
| Fix IaC misconfigs | 5 pts |
| Generate valid SBOM | 2 pts |
| Implement signing simulation | 2 pts |
| Bonus: Zero HIGH/CRITICAL in container | 3 pts |

## 🔧 Local Development

```bash
# Install dependencies
cd app && npm install

# Run app locally
npm run dev

# Build Docker image
docker build -t build-breaker:workshop .
```

## 🚦 Security Gate Configuration

Thresholds are configurable via environment variables:

- `SAST_MAX_HIGH`: Maximum high-severity SAST findings (default: 0)
- `SAST_MAX_MEDIUM`: Maximum medium-severity SAST findings (default: 0)
- `SCA_MAX_HIGH`: Maximum high-severity dependency issues (default: 0)
- `IMG_MAX_HIGH`: Maximum high-severity container issues (default: 0)

## 📝 Allow Lists

- `.trivyignore`: Allowlist for Trivy findings
- `.checkov.yaml`: Policy skips for Checkov
- `.secrets-allow`: Allowlist for secrets patterns

