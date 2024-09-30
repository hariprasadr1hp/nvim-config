// Gleam example to test editor settings

// Importing modules
import gleam/io
import gleam/string.{concat, length}

// Define a public constant
pub const pi = 3.14159

// Define a public function with type annotations
pub fn add(x: Int, y: Int) -> Int {
  x + y
}

// Define a private function (not accessible outside this module)
fn subtract(x: Int, y: Int) -> Int {
  x - y
}

// Define a function using pattern matching
pub fn describe_number(n: Int) -> String {
  case n {
    0 -> "Zero"
    1 -> "One"
    2 -> "Two"
    _ -> "Other"
  }
}

// Define a function that uses recursion (factorial)
pub fn factorial(n: Int) -> Int {
  case n {
    0 -> 1
    _ -> n * factorial(n - 1)
  }
}

// Define an Enum (also known as a sum type)
pub type Color {
  Red
  Green
  Blue
}

// Function that matches against the `Color` enum
pub fn color_to_string(color: Color) -> String {
  case color {
    Red -> "Red"
    Green -> "Green"
    Blue -> "Blue"
  }
}

// Define a Tuple type and return a tuple
pub fn create_point(x: Int, y: Int) -> #(Int, Int) {
  #(x, y)
}

// Using records (structs)
pub type Person {
  Person(name: String, age: Int, email: String)
}

// Create a record and return it
pub fn create_person(name: String, age: Int, email: String) -> Person {
  Person(name, age, email)
}

// Accessing fields from a record
pub fn greet_person(person: Person) -> String {
  concat("Hello, ", person.name)
}

// Working with Option (nullable) types
pub fn find_item(index: Int, items: List(String)) -> Option(String) {
  case List.at(items, index) {
    Some(item) -> Some(item)
    None -> None
  }
}

// Handling Option with case expressions
pub fn get_item_or_default(index: Int, items: List(String)) -> String {
  case find_item(index, items) {
    Some(item) -> item
    None -> "Unknown"
  }
}

// Using the Result type for error handling
pub fn divide(x: Float, y: Float) -> Result(Float, String) {
  case y {
    0.0 -> Error("Cannot divide by zero")
    _ -> Ok(x / y)
  }
}

// Define a higher-order function (accepting a function as an argument)
pub fn apply_twice(f: fn(Int) -> Int, x: Int) -> Int {
  f(f(x))
}

// Example of anonymous functions
pub fn example_anonymous_function() -> Int {
  let square = fn(x: Int) -> Int { x * x }
  apply_twice(square, 3)
}

// Working with lists
pub fn list_example() -> List(Int) {
  let numbers = [1, 2, 3, 4, 5]
  List.map(fn(n) { n * 2 }, numbers)
}

// Working with strings
pub fn string_example() -> String {
  let greeting = "Hello"
  let name = "Gleam"
  concat(greeting, name)
}

// Using pipes for function composition
pub fn pipe_example() -> String {
  let message = "Hello, World!"
  message
  |> length
  |> Int.to_string
}

// Working with modules and exposing functions
pub fn main() {
  let result = add(10, 20)
  io.println(concat("Addition result: ", Int.to_string(result)))

  let color = Red
  io.println(color_to_string(color))

  let person = create_person("Alice", 30, "alice@example.com")
  io.println(greet_person(person))

  // Handling Option type
  let items = ["apple", "banana", "cherry"]
  let item = get_item_or_default(1, items)
  io.println(item)

  // Handling Result type
  case divide(10.0, 2.0) {
    Ok(result) -> io.println(Float.to_string(result))
    Error(error) -> io.println(error)
  }

  // Higher-order function usage
  let result = apply_twice(fn(x) { x + 1 }, 5)
  io.println(Int.to_string(result))

  // Using pipes
  let message_length = pipe_example()
  io.println(message_length)
}

