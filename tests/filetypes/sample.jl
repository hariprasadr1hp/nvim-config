# Julia example to test editor settings

# Variables and basic types
x = 10               # Integer
y = 3.14             # Float
name = "Julia"       # String
is_active = true     # Boolean

# Constants
const PI_APPROX = 3.14159

# Arrays and ranges
numbers = [1, 2, 3, 4, 5]
range_values = 1:10   # Range from 1 to 10

# Dictionaries (similar to hash maps)
grades = Dict("Alice" => 85, "Bob" => 92, "Charlie" => 78)

# Print to the console
println("Hello, $name!")

# Arithmetic operations
sum_val = x + y
diff_val = x - y
prod_val = x * y
quot_val = x / y

println("Sum: $sum_val, Difference: $diff_val, Product: $prod_val, Quotient: $quot_val")

# Conditional statements
if x > y
    println("$x is greater than $y")
elseif x < y
    println("$x is less than $y")
else
    println("$x is equal to $y")
end

# Loops

# For loop with a range
for i in 1:5
    println("For loop iteration: $i")
end

# For loop with an array
for num in numbers
    println("Number: $num")
end

# While loop
i = 1
while i <= 5
    println("While loop iteration: $i")
    i += 1
end

# Functions

# Function with return value
function add(a, b)
    return a + b
end

result = add(5, 10)
println("Addition result: $result")

# Anonymous function (lambda)
square = x -> x^2
println("Square of 4: $(square(4))")

# Recursive function (factorial)
function factorial(n)
    if n == 0
        return 1
    else
        return n * factorial(n - 1)
    end
end

println("Factorial of 5: $(factorial(5))")

# Broadcasting
double_numbers = 2 .* numbers
println("Doubled numbers: $double_numbers")

# Working with strings
greeting = "Hello"
target = "world"
full_greeting = "$greeting, $target!"
println(full_greeting)

# String manipulation
uppercase_greeting = uppercase(full_greeting)
println("Uppercase greeting: $uppercase_greeting")

# Structs (custom types)
struct Point
    x::Float64
    y::Float64
end

# Create an instance of the struct
p = Point(3.0, 4.0)
println("Point: ($(p.x), $(p.y))")

# Parametric types
struct Box{T}
    value::T
end

int_box = Box(123)
str_box = Box("Julia")

println("Box with Int: $(int_box.value), Box with String: $(str_box.value)")

# Error handling
try
    result = 10 / 0
catch e
    println("Caught an error: ", e)
finally
    println("This runs no matter what.")
end

# Arrays and list comprehensions
squared_numbers = [x^2 for x in 1:5]
println("Squared numbers: $squared_numbers")

# Using the map function
squared = map(x -> x^2, numbers)
println("Mapped squared values: $squared")

# Using the filter function
even_numbers = filter(x -> x % 2 == 0, numbers)
println("Even numbers: $even_numbers")

# Modules

# Defining a module (in the same file for simplicity)
module MyModule

export greet, square

# Function inside the module
function greet(name)
    println("Hello, $name!")
end

# Another function
square(x) = x^2

end

# Using the module
using .MyModule

greet("Julia")
println("Square of 7: $(square(7))")

# Plotting example (if using the `Plots` package, install with `import Pkg; Pkg.add("Plots")`)
# using Plots
# x = 0:0.1:10
# y = sin.(x)
# plot(x, y, title="Sine Wave", xlabel="x", ylabel="sin(x)")


