// C# example to test editor settings

using System;
using System.Collections.Generic;

class Program
{
    static void Main(string[] args)
    {
        // Variables and constants
        string name = "C#";
        const double version = 10.0;

        // Print a message
        Console.WriteLine($"Hello, {name}! Version: {version}");

        // Call a method
        int result = Add(5, 10);
        Console.WriteLine($"Sum of 5 and 10: {result}");

        // Conditional statement
        if (result > 10)
        {
            Console.WriteLine("Result is greater than 10");
        }
        else
        {
            Console.WriteLine("Result is less than or equal to 10");
        }

        // Arrays and loops
        int[] numbers = { 1, 2, 3, 4, 5 };
        foreach (int num in numbers)
        {
            Console.WriteLine($"Number: {num}");
        }

        // Dictionary (similar to map)
        Dictionary<string, object> person = new Dictionary<string, object>
        {
            { "name", "Alice" },
            { "age", 30 },
            { "email", "alice@example.com" }
        };
        Console.WriteLine($"{person["name"]} is {person["age"]} years old.");

        // Call a method from a class
        Person person1 = new Person("Bob", 35);
        Console.WriteLine(person1.Greet());

        // Handling null values with nullable types
        string? optionalString = "This is a nullable string";
        if (optionalString != null)
        {
            Console.WriteLine($"Optional string: {optionalString}");
        }

        // Lambda expression
        Func<int, int> square = x => x * x;
        Console.WriteLine($"Square of 4: {square(4)}");

        // Try-catch for exception handling
        try
        {
            FetchData("");
        }
        catch (Exception e)
        {
            Console.WriteLine($"Error fetching data: {e.Message}");
        }
    }

    // Method to add two numbers
    static int Add(int a, int b)
    {
        return a + b;
    }

    // Method that simulates fetching data and throws an exception
    static void FetchData(string url)
    {
        if (string.IsNullOrEmpty(url))
        {
            throw new ArgumentException("URL cannot be empty");
        }
        Console.WriteLine($"Fetching data from {url}");
    }
}

// Class with a method
class Person
{
    public string Name { get; set; }
    public int Age { get; set; }

    public Person(string name, int age)
    {
        Name = name;
        Age = age;
    }

    public string Greet()
    {
        return $"Hello, my name is {Name} and I am {Age} years old.";
    }
}

