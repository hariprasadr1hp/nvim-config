# AWK example to test editor settings

# Define a pattern and action: print lines with more than 10 characters
length($0) > 10 {
    print "Line with more than 10 characters: " $0
}

# Print the first and second fields of each line
{
    print "Field 1: " $1, "Field 2: " $2
}

# Define a BEGIN block to run before processing the input
BEGIN {
    FS = ","  # Set field separator to comma
    print "Starting to process the file..."
}

# Define an END block to run after processing the input
END {
    print "Finished processing the file."
}

# Perform a calculation and print the result
{
    sum = $2 + $3
    print "Sum of field 2 and 3: " sum
}

# Pattern-action pair to print lines where the first field equals "John"
$1 == "John" {
    print "Found John: " $0
}

# Count the number of lines processed
{
    count++
}
END {
    print "Total lines processed: " count
}

