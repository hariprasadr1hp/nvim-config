// Swift example to test editor settings

import Foundation

// Define a variable and a constant
var name: String = "Swift"
let version: Double = 5.5

// Print a message
print("Hello, \(name)! Version: \(version)")

// Function to add two numbers
func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

// Call the function
let result = add(5, 10)
print("Sum: \(result)")

// Conditional statement
if result > 10 {
    print("Result is greater than 10")
} else {
    print("Result is less than or equal to 10")
}

// Arrays and loops
let numbers = [1, 2, 3, 4, 5]
for number in numbers {
    print("Number: \(number)")
}

// Dictionary
let person: [String: Any] = [
    "name": "Alice",
    "age": 30,
    "email": "alice@example.com"
]
print("Person: \(person["name"] ?? "") is \(person["age"] ?? 0) years old.")

// Classes and objects
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func greet() -> String {
        return "Hello, my name is \(name) and I am \(age) years old."
    }
}

let person1 = Person(name: "Bob", age: 35)
print(person1.greet())

// Optionals and optional binding
var optionalString: String? = "This is an optional"
if let unwrappedString = optionalString {
    print("Unwrapped string: \(unwrappedString)")
} else {
    print("optionalString is nil")
}

// Closures
let square = { (x: Int) -> Int in
    return x * x
}
print("Square of 4: \(square(4))")

// Error handling
enum NetworkError: Error {
    case badURL
    case noData
}

func fetchData(from url: String) throws {
    if url.isEmpty {
        throw NetworkError.badURL
    }
    print("Data fetched from \(url)")
}

do {
    try fetchData(from: "")
} catch NetworkError.badURL {
    print("Bad URL provided.")
} catch {
    print("An unknown error occurred.")
}

