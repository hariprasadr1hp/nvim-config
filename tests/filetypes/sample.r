# R example to test editor settings

# Variables and basic types
x <- 10           # Integer
y <- 3.14         # Float
name <- "R"       # String
is_active <- TRUE # Boolean

# Vectors (Arrays in R)
numbers <- c(1, 2, 3, 4, 5)

# Data types and casting
x_as_char <- as.character(x)
y_as_integer <- as.integer(y)
is_active_as_numeric <- as.numeric(is_active)

# Data frame (similar to tables)
data <- data.frame(
  name = c("Alice", "Bob", "Charlie"),
  age = c(25, 30, 35),
  salary = c(60000, 70000, 80000)
)

# Access data frame elements
age_of_bob <- data$age[2]
print(paste("Bob's age is", age_of_bob))

# Arithmetic operations
sum_val <- x + y
diff_val <- x - y
prod_val <- x * y
quot_val <- x / y

# Print values
print(paste("Sum:", sum_val))
print(paste("Difference:", diff_val))
print(paste("Product:", prod_val))
print(paste("Quotient:", quot_val))

# Conditional statements
if (x > y) {
  print("x is greater than y")
} else if (x < y) {
  print("x is less than y")
} else {
  print("x is equal to y")
}

# Loops

# For loop with a vector
for (i in numbers) {
  print(paste("Number:", i))
}

# While loop
i <- 1
while (i <= 5) {
  print(paste("While loop iteration:", i))
  i <- i + 1
}

# Functions

# Simple function
add <- function(a, b) {
  return(a + b)
}

result <- add(5, 10)
print(paste("Addition result:", result))

# Anonymous function (lambda)
square <- function(x) x^2
print(paste("Square of 4:", square(4)))

# Function with default parameters
multiply <- function(a, b = 2) {
  return(a * b)
}
print(paste("Multiply with default:", multiply(3)))

# Apply function to vectors (vectorized operations)
double_numbers <- sapply(numbers, function(x) x * 2)
print("Doubled numbers:")
print(double_numbers)

# List (similar to arrays in R but can hold different types)
mixed_list <- list(42, "Hello", TRUE, c(1, 2, 3))
print("Mixed list:")
print(mixed_list)

# Working with strings
greeting <- "Hello"
target <- "world"
full_greeting <- paste(greeting, target, sep=", ")
print(full_greeting)

# String manipulation
uppercase_greeting <- toupper(full_greeting)
print(paste("Uppercase greeting:", uppercase_greeting))

# Built-in statistical functions
mean_value <- mean(numbers)
median_value <- median(numbers)
print(paste("Mean of numbers:", mean_value))
print(paste("Median of numbers:", median_value))

# Plotting example (if using graphical output)
plot(numbers, main="Simple Plot", xlab="Index", ylab="Value", col="blue", pch=16)

# Creating factors (categorical data)
status <- factor(c("single", "married", "single", "divorced", "married"))
print("Factor levels:")
print(levels(status))

# Error handling
tryCatch({
  result <- 10 / 0
}, warning = function(w) {
  print("Warning occurred!")
}, error = function(e) {
  print("Error occurred!")
}, finally = {
  print("End of error handling")
})

# Data manipulation with dplyr (Install the package if necessary)
# install.packages("dplyr")
library(dplyr)

# Filter rows based on a condition
filtered_data <- filter(data, age > 25)
print("Filtered data (age > 25):")
print(filtered_data)

# Select specific columns
selected_data <- select(data, name, salary)
print("Selected columns (name, salary):")
print(selected_data)

# Arrange data by a specific column
arranged_data <- arrange(data, desc(age))
print("Data arranged by age (descending):")
print(arranged_data)

# Summarize data
summary_data <- summarize(data, avg_salary = mean(salary))
print("Summary (average salary):")
print(summary_data)

# Grouping and summarizing data
grouped_summary <- data %>%
  group_by(name) %>%
  summarize(avg_salary = mean(salary))
print("Grouped summary:")
print(grouped_summary)

