<?php
// PHP example to test editor settings

// Define a constant
define("SITE_NAME", "Example Site");

// Define variables
$name = "John Doe";
$age = 30;
$is_active = true;

// Print output
echo "Hello, $name! Welcome to " . SITE_NAME . ".<br>";
echo "Age: $age<br>";

// Conditional statements
if ($is_active) {
    echo "User is active.<br>";
} else {
    echo "User is not active.<br>";
}

// Define a function
function add($a, $b) {
    return $a + $b;
}

$result = add(5, 10);
echo "Addition result: $result<br>";

// Arrays and loops
$numbers = [1, 2, 3, 4, 5];

echo "Numbers:<br>";
foreach ($numbers as $num) {
    echo "$num<br>";
}

// Associative array
$person = [
    "name" => "Alice",
    "age" => 28,
    "email" => "alice@example.com"
];

echo "Name: " . $person["name"] . "<br>";
echo "Age: " . $person["age"] . "<br>";

// Working with classes and objects
class Person {
    public $name;
    public $age;

    public function __construct($name, $age) {
        $this->name = $name;
        $this->age = $age;
    }

    public function greet() {
        return "Hello, my name is $this->name and I am $this->age years old.";
    }
}

$person1 = new Person("Bob", 35);
echo $person1->greet() . "<br>";

// Working with files
$file = fopen("example.txt", "w");
fwrite($file, "This is a test file written in PHP.\n");
fclose($file);

// Read the file
$file = fopen("example.txt", "r");
while (!feof($file)) {
    echo fgets($file) . "<br>";
}
fclose($file);

// Error handling
try {
    if (!file_exists("nonexistent.txt")) {
        throw new Exception("File does not exist.");
    }
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "<br>";
}
?>

