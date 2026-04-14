.PHONY: help setup install dev run clean build up down logs restart clean-all

.DEFAULT_GOAL := help

# Colors
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m

VENV := .venv
UV := uv

help: ## Show this help
	@echo "$(BLUE)Hybrid Document Search with Qdrant and Sentence Transformers$(NC)"
	@echo ""
	@echo "$(GREEN)Usage:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'

# ============================================================================
# Setup & Installation
# ============================================================================

setup: ## Initial setup (create .env, install deps)
	@if [ ! -f .env ]; then \
		echo "$(BLUE)Creating .env file...$(NC)"; \
		cp .env.example .env; \
		echo "$(GREEN)✓ .env created$(NC)"; \
		echo "$(YELLOW)⚠ Edit .env and add your API key$(NC)"; \
	else \
		echo "$(YELLOW).env already exists$(NC)"; \
	fi
	@if ! command -v uv >/dev/null 2>&1; then \
		echo "$(BLUE)Installing uv...$(NC)"; \
		curl -LsSf https://astral.sh/uv/install.sh | sh; \
	else \
		echo "$(GREEN)✓ uv is installed$(NC)"; \
	fi
	@echo "$(BLUE)Setting up virtual environment...$(NC)"
	@$(UV) sync
	@echo "$(GREEN)✓ Environment ready$(NC)"

install: ## Install dependencies
	@echo "$(BLUE)Syncing dependencies...$(NC)"
	@$(UV) sync
	@echo "$(GREEN)✓ Dependencies installed$(NC)"

# ============================================================================
# Development
# ============================================================================

dev: setup run ## Setup and run (one command to start!)

run: ## Start FastAPI server
	@echo "$(BLUE)Starting FastAPI server...$(NC)"
	@echo "$(YELLOW)API docs at: http://localhost:8000/docs$(NC)"
	@$(UV) run uvicorn main:app --reload --host 0.0.0.0 --port 8000

# ============================================================================
# Docker
# ============================================================================

build: ## Build Docker image
	@echo "$(BLUE)Building Docker image...$(NC)"
	docker compose build
	@echo "$(GREEN)✓ Built$(NC)"

up: ## Start container
	@echo "$(BLUE)Starting container...$(NC)"
	docker compose up -d
	@echo "$(GREEN)✓ Running at http://localhost:8000/docs$(NC)"

down: ## Stop container
	@echo "$(BLUE)Stopping container...$(NC)"
	docker compose down
	@echo "$(GREEN)✓ Stopped$(NC)"

logs: ## View container logs
	docker compose logs -f

restart: down up ## Restart container

# ============================================================================
# Cleanup
# ============================================================================

clean: ## Remove venv, cache, and temp files
	@echo "$(BLUE)Cleaning...$(NC)"
	rm -rf $(VENV)
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	@$(UV) cache clean
	@echo "$(GREEN)✓ Cleaned$(NC)"

clean-all: clean down ## Clean everything including Docker
	docker compose down -v
	@echo "$(GREEN)✓ Everything cleaned$(NC)"
