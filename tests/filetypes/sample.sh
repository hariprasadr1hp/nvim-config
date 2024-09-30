#!/bin/bash
# Bash example to test editor settings

# Variables
name="Bash Script"
x=10
y=20

# Print to the console
echo "Hello, $name!"

# Arithmetic operations
sum=$((x + y))
echo "Sum of $x and $y is: $sum"

# Conditional statements
if [ $x -gt $y ]; then
  echo "$x is greater than $y"
elif [ $x -lt $y ]; then
  echo "$x is less than $y"
else
  echo "$x is equal to $y"
fi

# Loops

# For loop
for i in {1..5}; do
  echo "For loop iteration: $i"
done

# While loop
i=1
while [ $i -le 5 ]; do
  echo "While loop iteration: $i"
  ((i++))
done

# Functions

# Define a function
add() {
  local a=$1
  local b=$2
  echo $((a + b))
}

# Call the function
result=$(add 5 10)
echo "Addition result: $result"

# Arrays
numbers=(1 2 3 4 5)
echo "Array elements: ${numbers[@]}"

# Loop through an array
for num in "${numbers[@]}"; do
  echo "Number: $num"
done

# File I/O

# Writing to a file
echo "This is a test file." > test.txt
echo "Bash scripting file handling." >> test.txt

# Reading from a file
while IFS= read -r line; do
  echo "$line"
done < test.txt

# Error handling
if [ ! -f "nonexistent.txt" ]; then
  echo "Error: File does not exist."
fi

