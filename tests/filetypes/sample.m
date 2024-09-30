% Octave example to test editor settings

% Variables and basic operations
x = 10;
y = 3.14;
name = "Octave";
is_active = true;

% Print a message
printf("Hello, %s!\n", name);

% Matrix operations
A = [1, 2, 3; 4, 5, 6; 7, 8, 9];
B = [9, 8, 7; 6, 5, 4; 3, 2, 1];

C = A + B;   % Matrix addition
D = A * B;   % Matrix multiplication

disp("Matrix C (A + B):");
disp(C);
disp("Matrix D (A * B):");
disp(D);

% Element-wise operations
E = A .* B;  % Element-wise multiplication
disp("Matrix E (Element-wise multiplication):");
disp(E);

% Conditional statements
if x > y
  disp("x is greater than y");
elseif x < y
  disp("x is less than y");
else
  disp("x is equal to y");
end

% Loops

% For loop
for i = 1:5
  printf("For loop iteration: %d\n", i);
end

% While loop
i = 1;
while i <= 5
  printf("While loop iteration: %d\n", i);
  i += 1;
end

% Functions

% Simple function definition
function z = add(a, b)
  z = a + b;
end

result = add(5, 10);
printf("Addition result: %d\n", result);

% Anonymous function (lambda)
square = @(x) x^2;
printf("Square of 4: %d\n", square(4));

% Plotting example
x = 0:0.1:10;
y = sin(x);

figure;
plot(x, y);
title("Sine Wave");
xlabel("x");
ylabel("sin(x)");

% Reading from a file
file_id = fopen("example.txt", "r");
if file_id != -1
  while ~feof(file_id)
    line = fgetl(file_id);
    disp(line);
  end
  fclose(file_id);
else
  disp("Error: File not found");
end

% Writing to a file
file_id = fopen("output.txt", "w");
fprintf(file_id, "This is a test file.\n");
fprintf(file_id, "Written by Octave script.\n");
fclose(file_id);

% Working with structs
person.name = "Alice";
person.age = 30;
person.salary = 50000;

printf("Name: %s, Age: %d, Salary: %.2f\n", person.name, person.age, person.salary);

