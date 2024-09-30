// C++ example to test editor settings

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <algorithm>
#include <memory>

// Macros
#define PI 3.14159
#define SQUARE(x) ((x) * (x))

// Enum class
enum class Color { Red, Green, Blue };

// Struct example
struct Point {
    int x;
    int y;
};

// Class example with inheritance
class Shape {
public:
    virtual double area() const = 0; // Pure virtual function (abstract class)
    virtual ~Shape() = default;      // Virtual destructor
};

class Circle : public Shape {
private:
    double radius;
    
public:
    // Constructor
    Circle(double r) : radius(r) {}

    // Overriding the area() function
    double area() const override {
        return PI * SQUARE(radius);
    }
};

class Rectangle : public Shape {
private:
    double width;
    double height;
    
public:
    // Constructor
    Rectangle(double w, double h) : width(w), height(h) {}

    // Overriding the area() function
    double area() const override {
        return width * height;
    }
};

// Function templates
template <typename T>
T add(T a, T b) {
    return a + b;
}

// Function with default arguments
int multiply(int a, int b = 2) {
    return a * b;
}

// Lambda functions
auto lambda = [](int a, int b) {
    return a + b;
};

// Smart pointers
std::shared_ptr<Circle> createCircle(double radius) {
    return std::make_shared<Circle>(radius);
}

// Namespaces
namespace MyNamespace {
    void printMessage() {
        std::cout << "Hello from MyNamespace!" << std::endl;
    }
}

// Function with reference and pointer parameters
void modifyValue(int& ref, int* ptr) {
    ref += 10;
    *ptr += 20;
}

// Exception handling
void exceptionExample(int num) {
    if (num == 0) {
        throw std::runtime_error("Division by zero is not allowed!");
    }
    std::cout << "10 / " << num << " = " << 10 / num << std::endl;
}

// Using STL containers (vector, map) and algorithms
void containerExample() {
    std::vector<int> numbers = {5, 3, 8, 6, 2};
    std::map<std::string, int> ages = {{"Alice", 25}, {"Bob", 30}, {"Charlie", 35}};

    // Sorting using STL algorithm
    std::sort(numbers.begin(), numbers.end());

    std::cout << "Sorted numbers: ";
    for (int n : numbers) {
        std::cout << n << " ";
    }
    std::cout << std::endl;

    // Iterating over map
    std::cout << "Ages map:" << std::endl;
    for (const auto& [name, age] : ages) {
        std::cout << name << ": " << age << std::endl;
    }
}

// Forward declaration
class ForwardDeclaredClass;

// Function pointer example
int (*functionPtr)(int, int) = multiply;

// Main function
int main() {
    // Output basic types
    std::cout << "PI: " << PI << std::endl;
    std::cout << "Square of 5: " << SQUARE(5) << std::endl;

    // Enum usage
    Color color = Color::Green;
    if (color == Color::Green) {
        std::cout << "The color is green." << std::endl;
    }

    // Struct usage
    Point p = {3, 4};
    std::cout << "Point: (" << p.x << ", " << p.y << ")" << std::endl;

    // Class and polymorphism
    Circle circle(5);
    Rectangle rectangle(4, 6);

    std::vector<std::shared_ptr<Shape>> shapes = {std::make_shared<Circle>(5), std::make_shared<Rectangle>(4, 6)};
    for (const auto& shape : shapes) {
        std::cout << "Shape area: " << shape->area() << std::endl;
    }

    // Function template
    std::cout << "Add integers: " << add(3, 4) << std::endl;
    std::cout << "Add doubles: " << add(2.5, 3.5) << std::endl;

    // Function with default arguments
    std::cout << "Multiply with default argument: " << multiply(5) << std::endl;

    // Lambda function
    std::cout << "Lambda result: " << lambda(5, 7) << std::endl;

    // Smart pointers
    auto myCircle = createCircle(10);
    std::cout << "Circle area using smart pointer: " << myCircle->area() << std::endl;

    // Namespaces
    MyNamespace::printMessage();

    // References and pointers
    int value = 10;
    modifyValue(value, &value);
    std::cout << "Modified value: " << value << std::endl;

    // Exception handling
    try {
        exceptionExample(0);
    } catch (const std::exception& ex) {
        std::cerr << "Caught exception: " << ex.what() << std::endl;
    }

    // STL containers and algorithms
    containerExample();

    // Function pointers
    std::cout << "Function pointer result: " << functionPtr(3, 5) << std::endl;

    return 0;
}
