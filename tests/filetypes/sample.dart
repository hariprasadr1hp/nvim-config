// Dart example to test editor settings

void main() {
  // Variables and constants
  String name = "Dart";
  const double version = 2.13;

  // Print a message
  print("Hello, $name! Version: $version");

  // Call a function
  int result = add(5, 10);
  print("Sum of 5 and 10: $result");

  // Conditional statement
  if (result > 10) {
    print("Result is greater than 10");
  } else {
    print("Result is less than or equal to 10");
  }

  // Loops with a list
  List<int> numbers = [1, 2, 3, 4, 5];
  for (var num in numbers) {
    print("Number: $num");
  }

  // Map (similar to a dictionary)
  Map<String, dynamic> person = {
    'name': 'Alice',
    'age': 30,
    'email': 'alice@example.com',
  };
  print("${person['name']} is ${person['age']} years old.");

  // Call a method from a class
  Person person1 = Person('Bob', 35);
  print(person1.greet());

  // Null safety with optionals
  String? optionalString = "This is a nullable string";
  optionalString?.let((s) => print("Optional string: $s"));

  // Anonymous function (lambda)
  var square = (int x) => x * x;
  print("Square of 4: ${square(4)}");

  // Try-catch for exception handling
  try {
    fetchData("https://example.com");
  } catch (e) {
    print("Error fetching data: $e");
  }
}

// Simple function to add two numbers
int add(int a, int b) {
  return a + b;
}

// Class with a method
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  String greet() {
    return "Hello, my name is $name and I am $age years old.";
  }
}

// Function that simulates throwing an exception
void fetchData(String url) {
  if (url.isEmpty) {
    throw ArgumentError("URL cannot be empty");
  }
  print("Fetching data from $url");
}

