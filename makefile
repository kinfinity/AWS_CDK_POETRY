# Makefile for AWS CDK Poetry Project Setup

PROJECT_SCRIPT = platforms/linux/generate_project.sh

.PHONY: help setup clean

help:
	@echo "Available make targets:"
	@echo "  setup       - Set up the AWS CDK Poetry project."
	@echo "  clean       - Clean up generated files."

setup:
	@./$(PROJECT_SCRIPT) $(PROJECT_NAME) $(SETUP_REQUIREMENTS)

clean:
	@echo "Cleaning up generated files..."
	@# Execute cleanup functions here

