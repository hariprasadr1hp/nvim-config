// Groovy example to test editor settings

// Variables and constants
def name = "Groovy"
final double version = 3.0

// Print a message
println "Hello, $name! Version: $version"

// Function to add two numbers
int add(int a, int b) {
    return a + b
}

// Call the function
def result = add(5, 10)
println "Sum of 5 and 10: $result"

// Conditional statement
if (result > 10) {
    println "Result is greater than 10"
} else {
    println "Result is less than or equal to 10"
}

// Lists and loops
def numbers = [1, 2, 3, 4, 5]
numbers.each { num ->
    println "Number: $num"
}

// Maps (similar to dictionaries)
def person = [
    name  : "Alice",
    age   : 30,
    email : "alice@example.com"
]
println "${person.name} is ${person.age} years old."

// Class and method
class Person {
    String name
    int age

    String greet() {
        return "Hello, my name is $name and I am $age years old."
    }
}

// Create an instance and call the method
def person1 = new Person(name: "Bob", age: 35)
println person1.greet()

// Closure (similar to lambda functions)
def square = { int x -> x * x }
println "Square of 4: ${square(4)}"

// Try-catch for exception handling
try {
    fetchData("")
} catch (Exception e) {
    println "Error fetching data: ${e.message}"
}

// Function that throws an exception
void fetchData(String url) {
    if (url.isEmpty()) {
        throw new IllegalArgumentException("URL cannot be empty")
    }
    println "Fetching data from $url"
}

