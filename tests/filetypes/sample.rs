// Rust example to test editor settings

// Importing external crates and standard library modules
use std::collections::HashMap;
use std::fs::{File, OpenOptions};
use std::io::{self, Read, Write};

// Enum with variants
enum Color {
    Red,
    Green,
    Blue,
}

// Struct with public and private fields
struct Person {
    name: String,
    age: u8,
    active: bool,
}

// Tuple struct
struct Point(i32, i32);

// Unit struct
struct UnitStruct;

// Implementations of structs
impl Person {
    // Constructor method (associated function)
    fn new(name: &str, age: u8) -> Self {
        Self {
            name: name.to_string(),
            age,
            active: true,
        }
    }

    // Instance method
    fn greet(&self) -> String {
        format!(
            "Hello, my name is {} and I am {} years old.",
            self.name, self.age
        )
    }

    // Mutable method
    fn celebrate_birthday(&mut self) {
        self.age += 1;
    }
}

// Traits and trait implementations
trait Describable {
    fn describe(&self) -> String;
}

impl Describable for Person {
    fn describe(&self) -> String {
        format!(
            "Person: {}, Age: {}, Active: {}",
            self.name, self.age, self.active
        )
    }
}

// Function with parameters, return type, and control flow
fn add(a: i32, b: i32) -> i32 {
    if a > b {
        a + b
    } else {
        b - a
    }
}

// Looping: for, while, loop
fn looping_example() {
    // For loop with range
    for i in 0..5 {
        println!("For loop iteration: {}", i);
    }

    // While loop
    let mut count = 0;
    while count < 5 {
        println!("While loop count: {}", count);
        count += 1;
    }

    // Infinite loop with break
    let mut loop_count = 0;
    loop {
        println!("Loop count: {}", loop_count);
        loop_count += 1;
        if loop_count >= 3 {
            break;
        }
    }
}

// Pattern matching with match and if let
fn match_example(color: Color) {
    match color {
        Color::Red => println!("Color is Red"),
        Color::Green => println!("Color is Green"),
        Color::Blue => println!("Color is Blue"),
    }
}

// Error handling with Result and Option
fn file_operations() -> io::Result<()> {
    let mut file = File::create("example.txt")?;
    file.write_all(b"Hello, world!")?;

    let mut content = String::new();
    let mut file = File::open("example.txt")?;
    file.read_to_string(&mut content)?;
    println!("File content: {}", content);

    Ok(())
}

fn option_example() {
    let some_value: Option<i32> = Some(42);
    let no_value: Option<i32> = None;

    match some_value {
        Some(v) => println!("Value: {}", v),
        None => println!("No value found"),
    }

    if let Some(v) = no_value {
        println!("Value: {}", v);
    } else {
        println!("No value found");
    }
}

// Generics example
fn identity<T>(value: T) -> T {
    value
}

// Using a HashMap
fn hashmap_example() {
    let mut scores: HashMap<&str, i32> = HashMap::new();
    scores.insert("Alice", 10);
    scores.insert("Bob", 15);

    for (key, value) in &scores {
        println!("Player: {}, Score: {}", key, value);
    }

    if let Some(score) = scores.get("Alice") {
        println!("Alice's score: {}", score);
    }
}

// Struct ownership and borrowing
fn borrowing_example() {
    let mut person = Person::new("Alice", 30);
    println!("{}", person.greet());

    // Mutable borrow to change the state
    person.celebrate_birthday();
    println!("After birthday: {}", person.greet());

    // Immutable borrow
    let greeting = person.greet();
    println!("{}", greeting);
}

// Lifetimes example
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// Closures and iterators
fn closure_and_iterator_example() {
    let numbers = vec![1, 2, 3, 4, 5];

    // Closure
    let add_one = |x: i32| x + 1;

    // Using an iterator
    let incremented_numbers: Vec<i32> = numbers.iter().map(|&x| add_one(x)).collect();

    println!("Incremented numbers: {:?}", incremented_numbers);
}

// Main function to run examples
fn main() {
    // Variables and constants
    let x: i32 = 10;
    let y: i32 = 20;
    const PI: f64 = 3.14159;

    println!("x: {}, y: {}, PI: {}", x, y, PI);
    println!("Addition: {}", add(x, y));

    // Struct and method examples
    let mut person = Person::new("Bob", 25);
    println!("{}", person.greet());
    person.celebrate_birthday();
    println!("{}", person.describe());

    // Looping examples
    looping_example();

    // Match examples
    match_example(Color::Green);

    // Option and Result examples
    option_example();
    if let Err(e) = file_operations() {
        println!("Error during file operations: {}", e);
    }

    // Generic function
    let num = identity(42);
    println!("Identity of 42: {}", num);

    // HashMap example
    hashmap_example();

    // Borrowing and ownership
    borrowing_example();

    // Lifetimes example
    let str1 = "Hello";
    let str2 = "World!";
    let result = longest(str1, str2);
    println!("Longest string: {}", result);

    // Closures and iterators
    closure_and_iterator_example();
}
