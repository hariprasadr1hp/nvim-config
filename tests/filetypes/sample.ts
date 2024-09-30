// TypeScript example to test editor settings

// Importing modules
import { promises as fs } from 'fs';

// Enum example
enum Color {
	Red = "RED",
	Green = "GREEN",
	Blue = "BLUE",
}

// Interface example
interface Person {
	name: string;
	age: number;
	greet(): string;
}

// Class example with inheritance
class Employee implements Person {
	// Class properties with visibility modifiers
	private employeeId: number;
	public name: string;
	public age: number;

	// Constructor
	constructor(employeeId: number, name: string, age: number) {
		this.employeeId = employeeId;
		this.name = name;
		this.age = age;
	}

	// Method
	public greet(): string {
		return `Hello, my name is ${this.name}, and I am ${this.age} years old.`;
	}

	// Getter
	public getEmployeeId(): number {
		return this.employeeId;
	}

	// Setter
	public setEmployeeId(id: number): void {
		this.employeeId = id;
	}
}

// Generic function
function identity<T>(arg: T): T {
	return arg;
}

// Union types and function overloading
function add(a: number, b: number): number;
function add(a: string, b: string): string;
function add(a: any, b: any): any {
	return a + b;
}

// Type Aliases
type StringOrNumber = string | number;

// Interface extension
interface Admin extends Person {
	role: string;
}

// Literal types
type AccessLevel = 'user' | 'admin' | 'guest';

// Tuple
let tupleExample: [string, number, boolean] = ["test", 42, true];

// Function with default parameters and rest parameters
function exampleFunction(
	arg1: number,
	arg2: string = "default",
	...rest: number[]
): void {
	console.log(`arg1: ${arg1}, arg2: ${arg2}, rest: ${rest}`);
}

// Async function with Promises
async function readFileAsync(filePath: string): Promise<string> {
	try {
		const data = await fs.readFile(filePath, 'utf8');
		return data;
	} catch (err) {
		console.error("Error reading file:", err);
		throw err;
	}
}

// Union types and type assertions
function logValue(value: StringOrNumber): void {
	if (typeof value === 'string') {
		console.log(`String: ${value.toUpperCase()}`);
	} else {
		console.log(`Number: ${value.toFixed(2)}`);
	}
}

// Enum usage
function getColorName(color: Color): string {
	return `Selected color is: ${color}`;
}

// Destructuring, spread operator, and rest parameters
function arrayOperations(): void {
	const numbers: number[] = [1, 2, 3, 4];
	const [first, ...rest] = numbers;
	console.log(`First number: ${first}`);
	console.log(`Rest of numbers: ${rest}`);

	const newNumbers = [...numbers, 5, 6];
	console.log(`New array: ${newNumbers}`);
}

// Conditional (ternary) operator
function max(a: number, b: number): number {
	return a > b ? a : b;
}

// Main function using async/await and all major features
async function main(): Promise<void> {
	// Variable declaration
	const name: string = "John";
	const age: number = 30;

	// Class instantiation
	const emp: Employee = new Employee(1, name, age);
	console.log(emp.greet());
	emp.setEmployeeId(2);
	console.log(`Employee ID: ${emp.getEmployeeId()}`);

	// Generic function
	const num = identity<number>(42);
	console.log(`Identity of 42: ${num}`);

	// Function overloads
	console.log(add(10, 20)); // 30
	console.log(add("Hello, ", "World!")); // Hello, World!

	// Type assertions
	logValue("Test string");
	logValue(100.567);

	// Enum and literal types
	const color: Color = Color.Blue;
	console.log(getColorName(color));

	// Destructuring and spread operator
	arrayOperations();

	// Function with default and rest parameters
	exampleFunction(5, "custom", 1, 2, 3);

	// Ternary operator
	console.log(`Max of 10 and 20: ${max(10, 20)}`);

	// Async operation
	try {
		const data = await readFileAsync('test.txt');
		console.log("File content:", data);
	} catch (error) {
		console.log("Failed to read file.");
	}
}

// Main function guard
if (require.main === module) {
	main().catch(err => console.error(err));
}

