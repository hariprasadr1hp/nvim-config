// F# example to test editor settings

// Variables and constants
let name = "F#"
let version = 5.0

// Print a message
printfn "Hello, %s! Version: %.1f" name version

// Function to add two numbers
let add a b = a + b

// Call the function
let result = add 5 10
printfn "Sum of 5 and 10: %d" result

// Conditional statement
if result > 10 then
    printfn "Result is greater than 10"
else
    printfn "Result is less than or equal to 10"

// Lists and loops
let numbers = [1; 2; 3; 4; 5]
for num in numbers do
    printfn "Number: %d" num

// Maps (similar to dictionaries)
let person = Map.ofList [("name", "Alice"); ("age", "30"); ("email", "alice@example.com")]
printfn "%s is %s years old." (person.["name"]) (person.["age"])

// Define a simple record type
type Person = { Name: string; Age: int }

let person1 = { Name = "Bob"; Age = 35 }
printfn "Hello, my name is %s and I am %d years old." person1.Name person1.Age

// Recursive function to calculate factorial
let rec factorial n =
    if n = 0 then 1
    else n * factorial (n - 1)

printfn "Factorial of 5: %d" (factorial 5)

// Lambda expression
let square = fun x -> x * x
printfn "Square of 4: %d" (square 4)

// Pattern matching
let processMessage message =
    match message with
    | "hello" -> printfn "Received a hello message"
    | "goodbye" -> printfn "Received a goodbye message"
    | _ -> printfn "Unknown message"

processMessage "hello"

// Try-catch for exception handling
try
    let fetchData url =
        if url = "" then failwith "URL cannot be empty"
        printfn "Fetching data from %s" url
    fetchData ""
with
| ex -> printfn "Error: %s" ex.Message

