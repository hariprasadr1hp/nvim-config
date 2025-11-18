# ============================================
# Configuration
# ============================================

TARGET = release
NVIM_CONFIG_DIR := $(CURDIR)
RUST_DIR := $(NVIM_CONFIG_DIR)/rust
RUST_PLUGIN ?= oxitools
RUST_CRATE_DIR := $(RUST_DIR)/$(RUST_PLUGIN)
RUST_LIB_NAME := $(RUST_PLUGIN)

# ============================================
# Detect OS → choose build ext vs install ext
# ============================================

UNAME_S := $(shell uname -s)

# What extension Cargo produces for the shared lib
ifeq ($(UNAME_S),Darwin)
  BUILD_EXT := dylib
else ifeq ($(UNAME_S),Linux)
  BUILD_EXT := so
else
  BUILD_EXT := dll
endif

# What extension Lua/Neovim expects for C modules
# On macOS and Linux, Lua looks for *.so
ifeq ($(UNAME_S),Darwin)
  INSTALL_EXT := so
else ifeq ($(UNAME_S),Linux)
  INSTALL_EXT := so
else
  INSTALL_EXT := dll
endif

# Path to built shared library
LIB_SRC  := $(RUST_CRATE_DIR)/target/$(TARGET)/lib$(RUST_LIB_NAME).$(BUILD_EXT)

# Destination: require("print_date") → lua/print_date.so
LIB_DEST := $(NVIM_CONFIG_DIR)/lua/$(RUST_PLUGIN).$(INSTALL_EXT)

# ============================================
# Targets
# ============================================

all:
	@echo "running make ..."

rs-plugin: rs-build rs-plugin-copy

rs-build:
	@echo "==> Building Rust plugin '$(RUST_PLUGIN)'"
	cd "$(RUST_CRATE_DIR)" && cargo build --$(TARGET)

rs-plugin-copy: build
	@echo "==> Installing $(RUST_PLUGIN) → $(LIB_DEST)"
	mkdir -p "$(NVIM_CONFIG_DIR)/lua"
	cp "$(LIB_SRC)" "$(LIB_DEST)"
	@echo "✔ Installed"

clean: rs-clean py-clean
	@echo "Cleaning up..."
	@echo "Clean up complete."

rs-clean:
	@echo "==> Cleaning plugin '$(RUST_PLUGIN)'"
	cd "$(RUST_CRATE_DIR)" && cargo clean

py-clean:
	find . -name '__pycache__' -exec rm -rf {} +
	find . -name '*.pyc' -exec rm -rf {} +
	rm -f junit.xml .coverage
	rm -rf .pytest_cache/
	rm -rf .ruff_cache/
	rm -rf __pycache__/
	rm -rf **/*/__pycache__/

rs-list-plugins:
	@echo "Rust plugins in $(RUST_DIR):"
	@ls -1 "$(RUST_DIR)"

.PHONY: rs-clean rs-plugins \
	py-clean \
	all build copy clean temp

