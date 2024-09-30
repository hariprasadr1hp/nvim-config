# Ruby example to test editor settings

# Single-line and multi-line comments
# This is a single-line comment

=begin
  This is a multi-line comment
  It can span multiple lines
=end

# Variables and basic data types
name = "John Doe"        # String
age = 30                 # Integer
height = 5.9             # Float
is_active = true         # Boolean
hobbies = ["reading", "coding", "hiking"]  # Array
address = { city: "New York", state: "NY", postal_code: 10001 }  # Hash

# String interpolation
puts "Hello, my name is #{name}, and I am #{age} years old."

# Arithmetic operations
sum = 5 + 3
difference = 10 - 4
product = 7 * 6
quotient = 40 / 8
remainder = 10 % 3
exponent = 2**3

puts "Sum: #{sum}, Difference: #{difference}, Product: #{product}, Quotient: #{quotient}, Remainder: #{remainder}, Exponent: #{exponent}"

# Conditional statements
if age >= 18
  puts "You are an adult."
elsif age < 18 && age > 12
  puts "You are a teenager."
else
  puts "You are a child."
end

# Case statement (switch equivalent)
weather = "sunny"
case weather
when "rainy"
  puts "Take an umbrella!"
when "sunny"
  puts "Wear sunglasses!"
else
  puts "Have a nice day!"
end

# Loops

# While loop
i = 0
while i < 5
  puts "While loop iteration: #{i}"
  i += 1
end

# Until loop (opposite of while)
j = 0
until j == 5
  puts "Until loop iteration: #{j}"
  j += 1
end

# For loop (using range)
for i in 1..5 do
  puts "For loop iteration: #{i}"
end

# Looping through arrays
hobbies.each do |hobby|
  puts "I enjoy #{hobby}."
end

# Hash iteration
address.each do |key, value|
  puts "#{key.capitalize}: #{value}"
end

# Methods (functions)

# Simple method with arguments and default values
def greet(name = "Guest")
  puts "Hello, #{name}!"
end

greet("Alice")
greet

# Method with return value
def add(a, b)
  return a + b
end

sum = add(3, 5)
puts "Sum: #{sum}"

# Method with variable arguments (splat operator)
def print_hobbies(*hobbies)
  hobbies.each { |hobby| puts "Hobby: #{hobby}" }
end

print_hobbies("Reading", "Traveling", "Cooking")

# Blocks, Procs, and Lambdas

# Using a block with an iterator
3.times do |i|
  puts "Block iteration: #{i}"
end

# Define a Proc (saved block of code)
square = Proc.new { |x| x * x }
puts "Square of 5: #{square.call(5)}"

# Define a Lambda
greet_lambda = ->(name) { puts "Hello from Lambda, #{name}!" }
greet_lambda.call("John")

# Classes and objects

class Person
  # Class-level variable
  @@count = 0

  # Constructor (initialize method)
  def initialize(name, age)
    @name = name  # Instance variable
    @age = age    # Instance variable
    @@count += 1
  end

  # Instance method
  def introduce
    puts "Hi, my name is #{@name} and I am #{@age} years old."
  end

  # Class method
  def self.total_people
    @@count
  end
end

# Create objects
person1 = Person.new("Alice", 28)
person2 = Person.new("Bob", 35)

# Call instance method
person1.introduce
person2.introduce

# Call class method
puts "Total people: #{Person.total_people}"

# Inheritance
class Employee < Person
  def initialize(name, age, job_title)
    super(name, age)  # Call superclass constructor
    @job_title = job_title
  end

  def work
    puts "#{@name} is working as #{@job_title}."
  end
end

# Create an employee object
employee = Employee.new("Carol", 30, "Software Engineer")
employee.introduce
employee.work

# Modules and mixins

module Greetings
  def say_hello
    puts "Hello!"
  end
end

class Student
  include Greetings  # Mixin
end

student = Student.new
student.say_hello

# Exception handling
begin
  result = 10 / 0  # This will raise an exception
rescue ZeroDivisionError => e
  puts "Error: Division by zero!"
ensure
  puts "This will always run."
end

# File handling

# Writing to a file
File.open("example.txt", "w") do |file|
  file.puts "This is an example file."
  file.puts "Ruby file handling is easy."
end

# Reading from a file
File.open("example.txt", "r") do |file|
  file.each_line { |line| puts line }
end

# Regular expressions
email = "john.doe@example.com"
if email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  puts "Valid email"
else
  puts "Invalid email"
end

# Symbols and constants
PI = 3.14159
puts "The value of PI is #{PI}."

status = :active
puts "Status: #{status}"

# Using `require` to import files (or libraries/gems)
# require 'some_library'  # Uncomment this line if you have a library to import

