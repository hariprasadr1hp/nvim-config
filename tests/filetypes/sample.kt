// Kotlin example to test editor settings

fun main() {
    // Variables and constants
    var name: String = "Kotlin"
    val version: Double = 1.5

    // Print a message
    println("Hello, $name! Version: $version")

    // Function call
    val result = add(5, 10)
    println("Sum of 5 and 10: $result")

    // Conditional statement
    if (result > 10) {
        println("Result is greater than 10")
    } else {
        println("Result is less than or equal to 10")
    }

    // Loops with a list
    val numbers = listOf(1, 2, 3, 4, 5)
    for (num in numbers) {
        println("Number: $num")
    }

    // Map (similar to a dictionary)
    val person = mapOf(
        "name" to "Alice",
        "age" to 30,
        "email" to "alice@example.com"
    )
    println("${person["name"]} is ${person["age"]} years old.")

    // Call a class method
    val person1 = Person("Bob", 35)
    println(person1.greet())

    // Null safety with optionals
    var optionalString: String? = "This is a nullable string"
    optionalString?.let {
        println("Optional string: $it")
    }

    // Lambda expression
    val square = { x: Int -> x * x }
    println("Square of 4: ${square(4)}")

    // Try-catch for exception handling
    try {
        fetchData("https://example.com")
    } catch (e: Exception) {
        println("Error fetching data: ${e.message}")
    }
}

// Simple function to add two numbers
fun add(a: Int, b: Int): Int {
    return a + b
}

// Class with a method
class Person(val name: String, val age: Int) {
    fun greet(): String {
        return "Hello, my name is $name and I am $age years old."
    }
}

// Simulating a function that throws an exception
fun fetchData(url: String) {
    if (url.isEmpty()) {
        throw IllegalArgumentException("URL cannot be empty")
    }
    println("Fetching data from $url")
}

