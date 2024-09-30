// Go example to test editor settings

package main

import (
	"errors"
	"fmt"
	"math"
	"strings"
	"time"
)

// Constants
const pi = 3.14159

// Global variables
var globalCounter int

// Struct definitions
type Person struct {
	Name string
	Age  int
}

type Employee struct {
	Person
	JobTitle string
	Salary   float64
}

// Interface example
type Describer interface {
	Describe() string
}

// Function with named return values
func add(a, b int) (sum int) {
	sum = a + b
	return
}

// Function with multiple return values and error handling
func divide(a, b float64) (float64, error) {
	if b == 0 {
		return 0, errors.New("cannot divide by zero")
	}
	return a / b, nil
}

// Method for the `Person` struct
func (p Person) Greet() string {
	return fmt.Sprintf("Hello, my name is %s, and I am %d years old.", p.Name, p.Age)
}

// Method for the `Employee` struct
func (e Employee) Describe() string {
	return fmt.Sprintf("%s is an employee working as a %s with a salary of $%.2f.", e.Name, e.JobTitle, e.Salary)
}

// Function with variadic arguments
func sum(values ...int) int {
	total := 0
	for _, v := range values {
		total += v
	}
	return total
}

// Goroutines and channels
func worker(id int, jobs <-chan int, results chan<- int) {
	for job := range jobs {
		fmt.Printf("Worker %d processing job %d\n", id, job)
		time.Sleep(time.Second) // Simulate work
		results <- job * 2
	}
}

func main() {
	// Local variables
	var x, y int = 5, 10
	z := add(x, y)
	fmt.Printf("Sum of %d and %d is: %d\n", x, y, z)

	// Array and slices
	numbers := []int{1, 2, 3, 4, 5}
	fmt.Println("Numbers:", numbers)

	// Range-based for loop
	for i, num := range numbers {
		fmt.Printf("Index %d: %d\n", i, num)
	}

	// Map (dictionary)
	grades := map[string]int{
		"Alice":   85,
		"Bob":     92,
		"Charlie": 78,
	}
	fmt.Println("Grades:", grades)

	// Accessing map values
	fmt.Printf("Alice's grade: %d\n", grades["Alice"])

	// Conditionals and error handling
	result, err := divide(10, 0)
	if err != nil {
		fmt.Println("Error:", err)
	} else {
		fmt.Println("Division result:", result)
	}

	// Loop with `continue` and `break`
	for i := 1; i <= 10; i++ {
		if i%2 == 0 {
			continue
		}
		if i > 7 {
			break
		}
		fmt.Println("Odd number:", i)
	}

	// String manipulation
	name := "GoLang"
	fmt.Println("Lowercase:", strings.ToLower(name))
	fmt.Println("Uppercase:", strings.ToUpper(name))
	fmt.Println("Contains 'Go':", strings.Contains(name, "Go"))

	// Calling struct methods
	person := Person{Name: "Alice", Age: 30}
	fmt.Println(person.Greet())

	employee := Employee{
		Person:   person,
		JobTitle: "Software Engineer",
		Salary:   85000,
	}
	fmt.Println(employee.Describe())

	// Calling a variadic function
	total := sum(1, 2, 3, 4, 5)
	fmt.Println("Total sum:", total)

	// Goroutines and channels example
	jobs := make(chan int, 5)
	results := make(chan int, 5)

	// Start 3 worker goroutines
	for w := 1; w <= 3; w++ {
		go worker(w, jobs, results)
	}

	// Send 5 jobs and then close the channel
	for j := 1; j <= 5; j++ {
		jobs <- j
	}
	close(jobs)

	// Collect results
	for a := 1; a <= 5; a++ {
		fmt.Println("Result:", <-results)
	}

	// Working with built-in math package
	radius := 5.0
	area := math.Pi * math.Pow(radius, 2)
	fmt.Printf("Area of circle with radius %.2f: %.2f\n", radius, area)

	// Time manipulation
	now := time.Now()
	fmt.Println("Current time:", now)
	fmt.Println("Time in 10 minutes:", now.Add(10*time.Minute))
	fmt.Println("Formatted time:", now.Format("2006-01-02 15:04:05"))
}
