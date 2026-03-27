.PHONY: all setup install-deps setup-db run clean

# Default target - run everything
all: setup run

# Full setup: install dependencies and setup database
setup: install-deps setup-db

# Install Python dependencies
install-deps:
	@echo "=== Installing Python dependencies ==="
	@if [ -d "venv" ]; then \
		echo "Using existing virtual environment..."; \
		. venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt; \
	else \
		echo "Creating virtual environment..."; \
		python3 -m venv venv && . venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt; \
	fi
	@echo "=== Dependencies installed ==="

# Setup PostgreSQL database
setup-db:
	@echo "=== Setting up PostgreSQL ==="
	@sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';" 2>/dev/null || true
	@echo "Database user configured"
	@echo "=== Checking PostgreSQL status ==="
	@sudo service postgresql status || sudo service postgresql start
	@echo "=== Database setup complete ==="

# Run the application
run:
	@echo "=== Starting Game Application ==="
	@python3 src/main.py

# Clean up (optional)
clean:
	@echo "=== Cleaning up ==="
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@echo "Cleanup complete"

# Help target
help:
	@echo "Available targets:"
	@echo "  all        - Full setup and run (default)"
	@echo "  setup      - Install dependencies and setup database"
	@echo "  install-deps - Install Python packages only"
	@echo "  setup-db   - Setup PostgreSQL database only"
	@echo "  run        - Run the application"
	@echo "  clean      - Remove cache files"
	@echo "  help       - Show this help message"
