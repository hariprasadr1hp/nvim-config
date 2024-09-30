# PowerShell example to test editor settings

# Variables
$name = "PowerShell"
$x = 10
$y = 20

# Print a message
Write-Host "Hello, $name!"

# Arithmetic operations
$sum = $x + $y
Write-Host "Sum of $x and $y is: $sum"

# Conditional statements
if ($x -gt $y) {
    Write-Host "$x is greater than $y"
} elseif ($x -lt $y) {
    Write-Host "$x is less than $y"
} else {
    Write-Host "$x is equal to $y"
}

# For loop
for ($i = 1; $i -le 5; $i++) {
    Write-Host "For loop iteration: $i"
}

# While loop
$i = 1
while ($i -le 5) {
    Write-Host "While loop iteration: $i"
    $i++
}

# Function definition
function Add-Numbers {
    param($a, $b)
    return $a + $b
}

# Call the function
$result = Add-Numbers 5 10
Write-Host "Addition result: $result"

# Arrays
$numbers = @(1, 2, 3, 4, 5)
Write-Host "Array elements: $numbers"

# Loop through an array
foreach ($num in $numbers) {
    Write-Host "Number: $num"
}

# Hash table (associative array)
$person = @{
    Name = "Alice"
    Age = 30
    Email = "alice@example.com"
}
Write-Host "Name: $($person.Name), Age: $($person.Age)"

# File I/O

# Write to a file
"Hello from PowerShell!" | Out-File -FilePath "example.txt"

# Read from a file
Get-Content -Path "example.txt" | ForEach-Object { Write-Host $_ }

# Error handling
try {
    Get-Item "nonexistent.txt"
} catch {
    Write-Host "Error: $_"
}

