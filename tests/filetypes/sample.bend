# Bend example to test editor settings

# Constants
const PI = 3.14159

# Variables and types
let x: Int = 10
let y: Float = 3.14
let name: String = "Bend"
let is_active: Bool = true

# Print output
print("Hello, {name}!")

# Functions
fn add(a: Int, b: Int) -> Int {
    return a + b
}

let result = add(5, 10)
print("Addition result: {result}")

# Conditionals
if x > y {
    print("{x} is greater than {y}")
} elif x < y {
    print("{x} is less than {y}")
} else {
    print("{x} is equal to {y}")
}

# Loops

# For loop with range
for i in 0..5 {
    print("For loop iteration: {i}")
}

# While loop
let mut i = 1
while i <= 5 {
    print("While loop iteration: {i}")
    i += 1
}

# Arrays
let numbers = [1, 2, 3, 4, 5]
for num in numbers {
    print("Number: {num}")
}

# Maps (Dictionaries)
let grades = {
    "Alice": 85,
    "Bob": 92,
    "Charlie": 78
}
print("Grades: {grades}")

# Structs and methods
struct Person {
    name: String
    age: Int

    fn greet(self) -> String {
        return "Hello, my name is {self.name} and I am {self.age} years old."
    }
}

let person = Person {
    name: "Alice",
    age: 30
}

print(person.greet())

# Option types (nullable values)
fn find_index(arr: [Int], target: Int) -> Option<Int> {
    for (i, val) in arr.enumerate() {
        if val == target {
            return Some(i)
        }
    }
    return None
}

let index = find_index(numbers, 3)
match index {
    Some(i) => print("Found at index: {i}"),
    None => print("Value not found")
}

# Error handling
fn divide(a: Float, b: Float) -> Result<Float, String> {
    if b == 0.0 {
        return Err("Cannot divide by zero".to_string())
    }
    return Ok(a / b)
}

let division_result = divide(10.0, 2.0)
match division_result {
    Ok(result) => print("Division result: {result}"),
    Err(error) => print("Error: {error}")
}

# Generics
fn identity<T>(value: T) -> T {
    return value
}

let num = identity(42)
let text = identity("Hello")

print("Generic value (Int): {num}")
print("Generic value (String): {text}")

