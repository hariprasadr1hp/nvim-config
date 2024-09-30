# Crystal example to test editor settings

# Variables and constants
name = "Crystal"
VERSION = 1.0

# Print a message
puts "Hello, #{name}! Version: #{VERSION}"

# Define a function to add two numbers
def add(a : Int32, b : Int32) : Int32
  a + b
end

# Call the function
result = add(5, 10)
puts "Sum of 5 and 10: #{result}"

# Conditional statement
if result > 10
  puts "Result is greater than 10"
else
  puts "Result is less than or equal to 10"
end

# Arrays and loops
numbers = [1, 2, 3, 4, 5]
numbers.each do |num|
  puts "Number: #{num}"
end

# Hash (similar to a dictionary)
person = {
  "name" => "Alice",
  "age" => 30,
  "email" => "alice@example.com"
}
puts "#{person["name"]} is #{person["age"]} years old."

# Define a class with a method
class Person
  property name : String
  property age : Int32

  def initialize(name : String, age : Int32)
    @name = name
    @age = age
  end

  def greet : String
    "Hello, my name is #{@name} and I am #{@age} years old."
  end
end

# Create an instance of the class
person1 = Person.new("Bob", 35)
puts person1.greet

# Nil safety (similar to optionals)
optional_string = "This is an optional string"
puts optional_string if optional_string

# Lambda (block) expression
square = ->(x : Int32) { x * x }
puts "Square of 4: #{square.call(4)}"

# Exception handling with try-catch
def fetch_data(url : String)
  raise ArgumentError.new("URL cannot be empty") if url.empty?
  puts "Fetching data from #{url}"
end

begin
  fetch_data("")
rescue ArgumentError => e
  puts "Error fetching data: #{e.message}"
end

