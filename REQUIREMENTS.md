# Build-Breaker Challenge - Requirements

## System Requirements

### Minimum Hardware
- **RAM**: 4GB minimum, 8GB recommended
- **Storage**: 2GB free disk space
- **CPU**: Any modern processor (2015+)
- **Network**: Internet connection for tool downloads

### Supported Operating Systems
- **macOS**: 10.15+ (Catalina or later)
- **Linux**: Ubuntu 18.04+, CentOS 7+, RHEL 7+
- **Windows**: Windows 10+ with WSL2

## Required Software

### Core Tools
| Tool | Version | Purpose | Installation |
|------|---------|---------|--------------|
| **Git** | 2.20+ | Version control | [git-scm.com](https://git-scm.com/) |
| **Node.js** | 20+ | Runtime for TypeScript app | [nodejs.org](https://nodejs.org/) |
| **npm** | 9+ | Package manager | Comes with Node.js |
| **Docker** | 20.10+ | Container runtime | [docker.com](https://docker.com/) |
| **Python** | 3.8+ | Security tools runtime | [python.org](https://python.org/) |
| **pip** | 21+ | Python package manager | Comes with Python |

### Security Tools
| Tool | Version | Purpose | Installation |
|------|---------|---------|--------------|
| **Semgrep** | 1.0+ | Static analysis (SAST) | `pip install semgrep` |
| **Checkov** | 2.0+ | Infrastructure scanning | `pip install checkov` |
| **Trivy** | 0.40+ | Vulnerability scanning | See platform-specific instructions |
| **Syft** | 0.80+ | SBOM generation | See platform-specific instructions |

## Platform-Specific Installation

### macOS (Homebrew)
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install tools
brew install git node docker
pip3 install semgrep checkov
brew install trivy syft
```

### Ubuntu/Debian
```bash
# Update package list
sudo apt-get update

# Install core tools
sudo apt-get install -y git nodejs npm python3 python3-pip docker.io

# Install Trivy
sudo apt-get install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy

# Install Syft
curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

# Install Python tools
pip3 install semgrep checkov
```

### CentOS/RHEL
```bash
# Install EPEL repository
sudo yum install -y epel-release

# Install core tools
sudo yum install -y git nodejs npm python3 python3-pip docker

# Install Trivy
sudo yum install -y wget
wget -qO - https://aquasecurity.github.io/trivy-repo/rpm/public.key | sudo rpm --import -
echo "deb https://aquasecurity.github.io/trivy-repo/rpm $(lsb_release -sc) main" | sudo tee -a /etc/yum.repos.d/trivy.repo
sudo yum install -y trivy

# Install Syft
curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

# Install Python tools
pip3 install semgrep checkov
```

### Windows (WSL2)
```bash
# Install WSL2 and Ubuntu
wsl --install

# In WSL2 Ubuntu, follow Ubuntu instructions above
# Or use Chocolatey in Windows:
choco install git nodejs docker-desktop python
pip install semgrep checkov
choco install trivy
# Download Syft from GitHub releases
```

## Verification

### Test Installation
```bash
# Clone the repository
git clone https://github.com/mlnas/BuildBreaker.git
cd BuildBreaker

# Run the setup test
./test-setup.sh
```

### Manual Verification
```bash
# Check each tool
git --version
node --version
npm --version
docker --version
python3 --version
pip3 --version
semgrep --version
checkov --version
trivy --version
syft --version
```

## Troubleshooting

### Common Issues

**Docker not running:**
```bash
# macOS: Start Docker Desktop application
# Linux: 
sudo systemctl start docker
sudo systemctl enable docker
```

**Permission denied for Docker:**
```bash
# Add user to docker group
sudo usermod -aG docker $USER
# Log out and back in
```

**Python tools not found:**
```bash
# Use python3 and pip3 explicitly
python3 -m pip install semgrep checkov
```

**Node.js version too old:**
```bash
# Use Node Version Manager (nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 20
nvm use 20
```

## Workshop Preparation

### For Facilitators
1. **Pre-workshop**: Send requirements list to participants
2. **Setup time**: Allow 15-20 minutes for tool installation
3. **Verification**: Run `./test-setup.sh` to confirm setup
4. **Backup plan**: Have pre-built Docker images ready

### For Participants
1. **Before workshop**: Install all required tools
2. **Test setup**: Run `make pass` to verify basic functionality
3. **Network**: Ensure stable internet connection
4. **Resources**: Close unnecessary applications to free RAM

## Support

If you encounter issues:
1. Check the troubleshooting section above
2. Verify all tools are installed and accessible
3. Ensure Docker is running
4. Check internet connectivity
5. Contact the workshop facilitator
