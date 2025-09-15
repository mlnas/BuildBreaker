.PHONY: setup lint secrets sca iac build imgscan sbom verify all pass fail

setup: ## Install local tooling
	@echo "Installing dependencies..."
	cd app && npm install
	@echo "Optional: pip install semgrep checkov"
	@echo "Optional: brew install trivy syft"

lint: ## Run SAST scan
	@./scripts/scan_sast.sh

secrets: ## Run secrets scan
	@./scripts/scan_secrets.sh

sca: ## Run dependency scan
	@./scripts/scan_sca.sh

iac: ## Run IaC scan
	@./scripts/scan_iac.sh

build: ## Build Docker image
	cd app && docker build -t build-breaker:workshop .

imgscan: ## Run container scan
	@./scripts/scan_container.sh

sbom: ## Generate SBOM
	@./scripts/make_sbom.sh

verify: ## Verify image signature
	@./scripts/verify_sign.sh

all: secrets lint sca build iac imgscan sbom verify ## Run all checks

pass: ## Run minimal gates (should pass)
	@echo "Running minimal security gates..."
	@cd app && npm ci && npm run build
	@echo "✅ Basic pipeline passed"

fail: ## Run hardened gates (should fail initially)
	@echo "Running hardened security gates..."
	@export SAST_MAX_HIGH=0 SAST_MAX_MEDIUM=0 && \
	export SCA_MAX_HIGH=0 IMG_MAX_HIGH=0 && \
	$(MAKE) all

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
