// JavaScript example to test editor settings

// Variables: var, let, const
var globalVar = "I am global";
let mutableLet = 42;
const constantValue = "I cannot be changed";

// Function declaration and function expressions
function declaredFunction(a, b) {
  return a + b;
}

const expressionFunction = function (a, b) {
  return a * b;
};

// Arrow function
const arrowFunction = (a, b) => a - b;

// Immediately Invoked Function Expression (IIFE)
(function () {
  console.log("IIFE is executed!");
})();

// Control flow: if, else if, else, switch
function checkNumber(n) {
  if (n > 10) {
    console.log("Greater than 10");
  } else if (n === 10) {
    console.log("Exactly 10");
  } else {
    console.log("Less than 10");
  }

  // Switch case
  switch (n) {
    case 5:
      console.log("Number is 5");
      break;
    case 10:
      console.log("Number is 10");
      break;
    default:
      console.log("Unknown number");
  }
}

// Loops: for, while, do-while, for...of, for...in
function loopExamples() {
  // For loop
  for (let i = 0; i < 5; i++) {
    console.log(`For loop: ${i}`);
  }

  // While loop
  let i = 0;
  while (i < 5) {
    console.log(`While loop: ${i}`);
    i++;
  }

  // Do-while loop
  let j = 0;
  do {
    console.log(`Do-while loop: ${j}`);
    j++;
  } while (j < 5);

  // For...of (iterating over arrays)
  const arr = [10, 20, 30, 40];
  for (let value of arr) {
    console.log(`For...of loop: ${value}`);
  }

  // For...in (iterating over object properties)
  const obj = { a: 1, b: 2, c: 3 };
  for (let key in obj) {
    console.log(`For...in loop: ${key} = ${obj[key]}`);
  }
}

// Objects and methods
const person = {
  name: "Alice",
  age: 25,
  greet: function () {
    return `Hello, my name is ${this.name}`;
  },
  changeAge(newAge) {
    this.age = newAge;
  },
};

// Classes and inheritance
class Animal {
  constructor(name) {
    this.name = name;
  }

  speak() {
    console.log(`${this.name} makes a noise.`);
  }
}

class Dog extends Animal {
  constructor(name) {
    super(name); // Call the parent constructor
  }

  speak() {
    console.log(`${this.name} barks.`);
  }
}

const dog = new Dog("Buddy");
dog.speak(); // Buddy barks

// Promises and async/await
function simulateAsyncOperation() {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve("Async operation completed");
    }, 1000);
  });
}

async function asyncExample() {
  try {
    const result = await simulateAsyncOperation();
    console.log(result);
  } catch (error) {
    console.error("Error:", error);
  }
}

// Higher-order functions and callbacks
function higherOrderFunction(callback) {
  callback();
}

higherOrderFunction(() => {
  console.log("Callback executed");
});

// Map, filter, and reduce
function arrayManipulations() {
  const numbers = [1, 2, 3, 4, 5];

  const doubled = numbers.map((n) => n * 2);
  console.log(`Doubled: ${doubled}`);

  const evens = numbers.filter((n) => n % 2 === 0);
  console.log(`Evens: ${evens}`);

  const sum = numbers.reduce((acc, curr) => acc + curr, 0);
  console.log(`Sum: ${sum}`);
}

// Error handling: try, catch, finally
function errorHandlingExample() {
  try {
    throw new Error("Something went wrong!");
  } catch (error) {
    console.error("Caught an error:", error.message);
  } finally {
    console.log("Finally block executed.");
  }
}

// Destructuring arrays and objects
function destructuringExample() {
  // Array destructuring
  const [a, b, c] = [1, 2, 3];
  console.log(`a: ${a}, b: ${b}, c: ${c}`);

  // Object destructuring
  const { name, age } = person;
  console.log(`Name: ${name}, Age: ${age}`);
}

// Spread and Rest operators
function spreadRestExample(...args) {
  console.log("Rest parameters:", args);

  const arr1 = [1, 2, 3];
  const arr2 = [...arr1, 4, 5];
  console.log("Spread operator:", arr2);
}

// Template literals and tagged templates
function templateLiteralsExample() {
  const name = "Bob";
  const age = 30;
  console.log(`My name is ${name}, and I am ${age} years old.`);

  function tag(strings, ...values) {
    return strings.reduce(
      (result, str, i) => result + str + (values[i] || ""),
      "",
    );
  }
  const taggedResult = tag`My name is ${name}, and I am ${age} years old.`;
  console.log(taggedResult);
}

// Main function to run all examples
function main() {
  console.log("Variables:", globalVar, mutableLet, constantValue);

  console.log("Declared function:", declaredFunction(2, 3));
  console.log("Function expression:", expressionFunction(4, 5));
  console.log("Arrow function:", arrowFunction(9, 3));

  checkNumber(5);

  loopExamples();

  console.log("Person's greeting:", person.greet());
  person.changeAge(30);
  console.log("Person's new age:", person.age);

  asyncExample().then(() => {
    console.log("Async operation finished.");
  });

  arrayManipulations();
  errorHandlingExample();
  destructuringExample();
  spreadRestExample(1, 2, 3, 4, 5);
  templateLiteralsExample();
}

// Main guard
if (typeof window === "undefined") {
  main();
}
