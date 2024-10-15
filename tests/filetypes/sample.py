"""Python 3 example to test editor settings"""

import math
import os
from collections import defaultdict


# Keyword and function examples
def example_function(arg1, arg2=10):
    """
    This is a docstring.
    Function example to demonstrate multiple Python features.
    """

    # Control flow with if, elif, else
    if arg1 > arg2:
        result = arg1 + arg2
    elif arg1 == arg2:
        result = arg1 * arg2
    else:
        result = arg1 - arg2

    # Looping: for, while
    for i in range(5):
        print(f"Iteration {i}: result = {result}")
        result += i

    counter = 0
    while counter < 5:
        print(f"While loop, counter = {counter}")
        counter += 1

    # Try, except, finally
    try:
        division = arg1 / arg2
    except ZeroDivisionError:
        print("Division by zero is not allowed!")
        division = None
    finally:
        print("This will always execute.")

    # Function return statement
    return result, division


class ExampleClass:
    """Example of a class definition."""

    class_variable = 42

    def __init__(self, value):
        self.instance_variable = value

    # Class method
    def class_method(self):
        """class method"""
        print(f"Instance variable = {self.instance_variable}")

    @staticmethod
    def static_method():
        """static method"""
        print("This is a static method")

    # Magic methods
    def __repr__(self):
        return f"ExampleClass(value={self.instance_variable})"

    def __len__(self):
        return len(str(self.instance_variable))


# Lambda functions and list comprehensions
square = lambda x: x**2  # noqa: E731
squared_list = [square(x) for x in range(10) if x % 2 == 0]


# Working with files
def file_operations(filename):
    """file_operations"""
    with open(filename, "w", encoding="utf-8") as file:
        file.write("This is a test file.\n")

    with open(filename, "r", encoding="utf-8") as file:
        content = file.read()
        print(content)


def generator_example(n: int):
    """generator example"""
    for i in range(n):
        yield i**2


# Generators and yield
def multiple_arguments_with_types(arg1: int, arg2: float, arg3: str) -> list[str]:
    """a function with multiple arguments, type-annotated"""
    return [str(arg1), str(arg2), arg3]


# Dictionary with defaultdict
def defaultdict_example():
    """defaultdict example"""
    counts = defaultdict(int)
    words = ["apple", "banana", "apple", "orange", "banana", "banana"]
    for word in words:
        counts[word] += 1
    return counts


# Unpacking, sets, and tuples
def unpacking_example():
    """unpacking example"""
    # Tuple unpacking
    a, b = (5, 10)
    print(f"Unpacked values: a = {a}, b = {b}")

    # Set operations
    set1 = {1, 2, 3, 4}
    set2 = {3, 4, 5, 6}
    print(f"Union: {set1 | set2}")
    print(f"Intersection: {set1 & set2}")


def main():
    # Variables, arithmetic, and logic
    x, y = 20, 30
    sum_result = x + y
    is_greater = x > y

    # Print output
    print(f"x + y = {sum_result}")
    print(f"x > y? {is_greater}")

    # Function call
    res, div = example_function(x, y)
    print(f"Function result: {res}, Division: {div}")

    # Class instantiation
    obj = ExampleClass(100)
    obj.class_method()

    # Static method
    ExampleClass.static_method()

    # File operations
    filename = "test_file.txt"
    file_operations(filename)

    # Generator example
    for value in generator_example(5):
        print(f"Generated value: {value}")

    # Defaultdict example
    word_count = defaultdict_example()
    print(f"Word counts: {word_count}")

    # Unpacking example
    unpacking_example()

    # Using math module
    print(f"Square root of 16: {math.sqrt(16)}")

    # Conditional expression (ternary operator)
    max_value = x if x > y else y
    print(f"Max value between x and y: {max_value}")

    # Deleting a file
    os.remove(filename)


# Main guard (if __name__ == '__main__')
if __name__ == "__main__":
    main()
