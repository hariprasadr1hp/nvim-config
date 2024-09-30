// Java example to test editor settings

public class Main {
    public static void main(String[] args) {
        // Variables and constants
        String name = "Java";
        final double version = 17.0;

        // Print a message
        System.out.println("Hello, " + name + "! Version: " + version);

        // Call a method
        int result = add(5, 10);
        System.out.println("Sum of 5 and 10: " + result);

        // Conditional statement
        if (result > 10) {
            System.out.println("Result is greater than 10");
        } else {
            System.out.println("Result is less than or equal to 10");
        }

        // Loops with arrays
        int[] numbers = {1, 2, 3, 4, 5};
        for (int num : numbers) {
            System.out.println("Number: " + num);
        }

        // Map (HashMap)
        java.util.Map<String, Object> person = new java.util.HashMap<>();
        person.put("name", "Alice");
        person.put("age", 30);
        person.put("email", "alice@example.com");
        System.out.println(person.get("name") + " is " + person.get("age") + " years old.");

        // Call a method from a class
        Person person1 = new Person("Bob", 35);
        System.out.println(person1.greet());

        // Handling null values
        String optionalString = "This is a nullable string";
        if (optionalString != null) {
            System.out.println("Optional string: " + optionalString);
        }

        // Lambda expression
        java.util.function.Function<Integer, Integer> square = x -> x * x;
        System.out.println("Square of 4: " + square.apply(4));

        // Try-catch for exception handling
        try {
            fetchData("https://example.com");
        } catch (Exception e) {
            System.out.println("Error fetching data: " + e.getMessage());
        }
    }

    // Simple method to add two numbers
    public static int add(int a, int b) {
        return a + b;
    }

    // Simulating a method that throws an exception
    public static void fetchData(String url) throws Exception {
        if (url.isEmpty()) {
            throw new IllegalArgumentException("URL cannot be empty");
        }
        System.out.println("Fetching data from " + url);
    }
}

// Class with a method
class Person {
    private String name;
    private int age;

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String greet() {
        return "Hello, my name is " + name + " and I am " + age + " years old.";
    }
}

