# Makefile example to test editor settings

# Variables
CC = gcc
CFLAGS = -Wall -g
LDFLAGS = -lm
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
TARGET = $(BIN_DIR)/myapp

# Automatic variables:
# $@ - The file name of the target
# $< - The first prerequisite
# $^ - All the prerequisites

# Define source files and object files
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

# Default target
.PHONY: all
all: $(TARGET)

# Rule to build the target executable
$(TARGET): $(OBJS)
	@echo "Linking object files into $@"
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# Rule to compile source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	@echo "Compiling $< into $@"
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up generated files
.PHONY: clean
clean:
	@echo "Cleaning up..."
	@rm -rf $(OBJ_DIR) $(BIN_DIR) $(TARGET)

# Create the binary directory
.PHONY: create-bin-dir
create-bin-dir:
	@mkdir -p $(BIN_DIR)

# Rebuild target (clean and build)
.PHONY: rebuild
rebuild: clean all

# Test target using a test framework (e.g., running unit tests)
.PHONY: test
test:
	@echo "Running tests..."
	@./$(TARGET) --run-tests

# Phony targets explanation
# .PHONY is used to declare targets that are not associated with actual files.

# Using special built-in targets
.DEFAULT_GOAL := all # The default goal if `make` is run without arguments

# Define a pattern rule for multiple source types
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Target for debugging (print variables)
.PHONY: debug
debug:
	@echo "Source files: $(SRCS)"
	@echo "Object files: $(OBJS)"
	@echo "Compiler: $(CC)"
	@echo "Flags: $(CFLAGS)"

# Example of conditional statements (OS detection)
ifeq ($(OS), Windows_NT)
	CLEANUP_CMD = del /Q
else
	CLEANUP_CMD = rm -rf
endif

.PHONY: conditional-clean
conditional-clean:
	@$(CLEANUP_CMD) $(OBJ_DIR) $(BIN_DIR)
	@echo "Conditional clean executed."

# Example of a target with multiple prerequisites
.PHONY: build-steps
build-steps: create-bin-dir $(TARGET)
	@echo "Build steps completed."

