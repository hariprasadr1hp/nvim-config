// C example to test editor settings

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Constants
#define PI 3.14159

// Function declarations
int add(int a, int b);
void print_array(int arr[], int size);
void swap(int *a, int *b);
int factorial(int n);
void dynamic_memory_example();
void string_example();
void struct_example();
void file_io_example();

// Struct definition
struct Person {
    char name[50];
    int age;
    float salary;
};

// Main function
int main() {
    // Variables and basic data types
    int x = 10;
    float y = 3.14;
    char name[20] = "C Language";
    int numbers[] = {1, 2, 3, 4, 5};

    // Print variables
    printf("Integer: %d, Float: %.2f, String: %s\n", x, y, name);

    // Arithmetic operations
    int sum = add(x, 5);
    printf("Sum of %d and %d is: %d\n", x, 5, sum);

    // Arrays and loops
    printf("Array elements: ");
    print_array(numbers, 5);

    // Pointers and swapping values
    int a = 10, b = 20;
    printf("Before swap: a = %d, b = %d\n", a, b);
    swap(&a, &b);
    printf("After swap: a = %d, b = %d\n", a, b);

    // Recursion (factorial)
    int result = factorial(5);
    printf("Factorial of 5: %d\n", result);

    // String manipulation example
    string_example();

    // Struct example
    struct_example();

    // Dynamic memory allocation example
    dynamic_memory_example();

    // File I/O example
    file_io_example();

    return 0;
}

// Function definitions

// Add two integers
int add(int a, int b) {
    return a + b;
}

// Print elements of an array
void print_array(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

// Swap two integers using pointers
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// Recursive function to calculate factorial
int factorial(int n) {
    if (n == 0) {
        return 1;
    }
    return n * factorial(n - 1);
}

// Dynamic memory allocation example
void dynamic_memory_example() {
    int *arr;
    int size = 5;
    
    // Allocate memory
    arr = (int *)malloc(size * sizeof(int));
    
    if (arr == NULL) {
        printf("Memory allocation failed!\n");
        return;
    }

    // Assign values to allocated memory
    for (int i = 0; i < size; i++) {
        arr[i] = i * 10;
    }

    // Print allocated memory values
    printf("Dynamically allocated array: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    // Free allocated memory
    free(arr);
}

// String manipulation example
void string_example() {
    char str1[20] = "Hello";
    char str2[20] = "World";

    // Concatenate strings
    strcat(str1, str2);

    // Print concatenated string
    printf("Concatenated string: %s\n", str1);

    // String length
    printf("Length of string: %lu\n", strlen(str1));
}

// Struct example
void struct_example() {
    struct Person person1;
    
    // Assign values to struct members
    strcpy(person1.name, "Alice");
    person1.age = 30;
    person1.salary = 50000.0f;

    // Print struct members
    printf("Person: %s, Age: %d, Salary: %.2f\n", person1.name, person1.age, person1.salary);
}

// File I/O example
void file_io_example() {
    FILE *fptr;

    // Open file for writing
    fptr = fopen("example.txt", "w");

    if (fptr == NULL) {
        printf("Error opening file!\n");
        return;
    }

    // Write data to the file
    fprintf(fptr, "This is a test file.\n");
    fprintf(fptr, "C programming file handling.\n");

    // Close the file
    fclose(fptr);

    // Open file for reading
    fptr = fopen("example.txt", "r");

    if (fptr == NULL) {
        printf("Error opening file!\n");
        return;
    }

    // Read and print file content
    char ch;
    while ((ch = fgetc(fptr)) != EOF) {
        putchar(ch);
    }

    // Close the file
    fclose(fptr);
}

