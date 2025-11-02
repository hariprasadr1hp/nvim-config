.PHONY: all clean

clean:
	@echo "Cleaning up..."
	find . -name '__pycache__' -exec rm -rf {} +
	find . -name '*.pyc' -exec rm -rf {} +
	rm -f junit.xml .coverage
	rm -rf .pytest_cache/
	rm -rf .ruff_cache/
	rm -rf __pycache__/
	rm -rf **/*/__pycache__/
	@echo "Clean up complete."
