# Build-Breaker Challenge

A hands-on workshop for implementing security gates in Bitbucket Pipelines. This repo contains a deliberately vulnerable application and infrastructure code to practice implementing and fixing security controls.

##  Challenge

You're enabling security gates in Bitbucket Pipelines. The default branch passes with minimal checks. Your task is to:

1. Create a `hardened/yourname` branch
2. Enable the hardened security gates
3. Fix the security issues to get a green build

##  Prerequisites

### Required Software
- **Git** - For cloning and version control
- **Node.js 20+** - For running the TypeScript application
- **npm** - Node package manager (comes with Node.js)
- **Docker** - For container scanning and building
- **Python 3.8+** - For security tools
- **pip** - Python package manager

### Security Tools (Install before workshop)
```bash
# Install via pip
pip install semgrep checkov

# Install via package manager
# macOS (Homebrew)
brew install trivy syft

# Ubuntu/Debian
sudo apt-get update
sudo apt-get install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy

# Install Syft
curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

# Windows (Chocolatey)
choco install trivy
# Syft: Download from GitHub releases
```


### Docker Setup
```bash
# macOS: Install Docker Desktop from docker.com
# Linux: Install Docker Engine
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker is running
docker --version
docker run hello-world
```

##  Quick Start

```bash
# Clone the repository
git clone https://github.com/mlnas/BuildBreaker.git
cd BuildBreaker

# Setup local tools
make setup

# Verify all tools are installed
./test-setup.sh

# Run basic pipeline (should pass)
make pass

# Run hardened pipeline (should fail initially)
make fail
```

##  Security Gates

The hardened pipeline implements these security checks:

1. **Secrets Scanning**: Detect hardcoded credentials and sensitive data
2. **SAST**: Static analysis for code vulnerabilities
3. **SCA**: Software composition analysis for dependency vulnerabilities
4. **IaC Scanning**: Infrastructure-as-Code security checks
5. **Container Scanning**: Docker image vulnerability analysis
6. **SBOM**: Software Bill of Materials generation
7. **Image Signing**: Simulated container image signature verification

##  Known Issues to Fix

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

## Steps

1. Clone this repo
2. Create branch: `git checkout -b hardened/yourname`
3. Run `make fail` to see initial failures
4. Fix the issues one by one
5. Re-run `make fail` until all checks pass

## Points

| Task | Points |
|------|---------|
| Make pipeline fail on first run | 3 pts |
| Fix app SAST & SCA issues | 5 pts |
| Fix IaC misconfigs | 5 pts |
| Generate valid SBOM | 2 pts |
| Implement signing simulation | 2 pts |
| Bonus: Zero HIGH/CRITICAL in container | 3 pts |

## Local Development

```bash
# Install dependencies
cd app && npm install

# Run app locally
npm run dev

# Build Docker image
docker build -t build-breaker:workshop .
```

##  Security Gate Configuration

Thresholds are configurable via environment variables:

- `SAST_MAX_HIGH`: Maximum high-severity SAST findings (default: 0)
- `SAST_MAX_MEDIUM`: Maximum medium-severity SAST findings (default: 0)
- `SCA_MAX_HIGH`: Maximum high-severity dependency issues (default: 0)
- `IMG_MAX_HIGH`: Maximum high-severity container issues (default: 0)

## Allow Lists

- `.trivyignore`: Allowlist for Trivy findings
- `.checkov.yaml`: Policy skips for Checkov
- `.secrets-allow`: Allowlist for secrets patterns

