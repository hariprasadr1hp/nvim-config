# Perl example to test editor settings

# Variables and constants
my $name = "Perl";
my $version = 5.32;

# Print a message
print "Hello, $name! Version: $version\n";

# Function to add two numbers
sub add {
    my ($a, $b) = @_;
    return $a + $b;
}

# Call the function
my $result = add(5, 10);
print "Sum of 5 and 10: $result\n";

# Conditional statement
if ($result > 10) {
    print "Result is greater than 10\n";
} else {
    print "Result is less than or equal to 10\n";
}

# Arrays and loops
my @numbers = (1, 2, 3, 4, 5);
foreach my $num (@numbers) {
    print "Number: $num\n";
}

# Hash (similar to a dictionary)
my %person = (
    name  => "Alice",
    age   => 30,
    email => "alice\@example.com"
);
print "$person{name} is $person{age} years old.\n";

# Using subroutines
sub greet {
    my ($name, $age) = @_;
    return "Hello, my name is $name and I am $age years old.";
}

my $greeting = greet("Bob", 35);
print "$greeting\n";

# Error handling using eval
eval {
    fetch_data("");
};
if ($@) {
    print "Error fetching data: $@\n";
}

# Function that throws an error
sub fetch_data {
    my ($url) = @_;
    die "URL cannot be empty" if $url eq '';
    print "Fetching data from $url\n";
}

