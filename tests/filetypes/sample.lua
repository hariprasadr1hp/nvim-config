-- Lua example to test editor settings

-- Single-line comment

--[[ 
  Multi-line comment
]]

-- Variables and basic data types
local number = 10 -- Number
local boolean = true -- Boolean
local string = "Hello" -- String
local nilValue = nil -- Nil

-- Tables (associative arrays)
local person = {
	name = "John",
	age = 30,
	isActive = true,
}

-- Accessing table elements
print(person.name) -- John
print(person.age) -- 30

-- Updating table elements
person.age = 31
print(person.age) -- 31

-- Arrays (index-based tables)
local numbers = { 1, 2, 3, 4, 5 }

-- Looping through an array
for i = 1, #numbers do
	print("Number:", numbers[i])
end

-- Functions
function greet(name)
	return "Hello, " .. name .. "!"
end

print(greet("Alice")) -- Output: Hello, Alice!

-- Function with multiple return values
function addAndMultiply(a, b)
	return a + b, a * b
end

local sum, product = addAndMultiply(3, 5)
print("Sum:", sum) -- Output: 8
print("Product:", product) -- Output: 15

-- Anonymous function (lambda)
local anonymousFunction = function(x, y)
	return x - y
end

print(anonymousFunction(10, 3)) -- Output: 7

-- Conditional statements
local x = 10
if x > 5 then
	print("x is greater than 5")
elseif x == 5 then
	print("x is equal to 5")
else
	print("x is less than 5")
end

-- Loops

-- While loop
local count = 0
while count < 5 do
	print("Count:", count)
	count = count + 1
end

-- Repeat-until loop (similar to do-while)
repeat
	print("Repeating...")
	count = count - 1
until count == 0

-- For loop (numeric)
for i = 1, 5 do
	print("For loop iteration:", i)
end

-- For loop with step
for i = 1, 10, 2 do
	print("Step loop iteration:", i)
end

-- For loop (generic)
for key, value in pairs(person) do
	print(key, ":", value)
end

-- Metatables and metamethods
local vector = { x = 1, y = 2 }

-- Define a metatable with __add metamethod for vector addition
local vectorMeta = {
	__add = function(v1, v2)
		return { x = v1.x + v2.x, y = v1.y + v2.y }
	end,
	__tostring = function(v)
		return "Vector (" .. v.x .. ", " .. v.y .. ")"
	end,
}

-- Set the metatable for the vector
setmetatable(vector, vectorMeta)

-- Adding vectors using metamethods
local vector2 = { x = 3, y = 4 }
setmetatable(vector2, vectorMeta)

local result = vector + vector2
print(result) -- Output: Vector (4, 6)

-- Coroutines

-- Simple coroutine example
local function simpleCoroutine()
	print("Coroutine start")
	coroutine.yield() -- Yield execution
	print("Coroutine resumed")
end

local co = coroutine.create(simpleCoroutine)

-- Start the coroutine
coroutine.resume(co) -- Output: Coroutine start

-- Resume the coroutine
coroutine.resume(co) -- Output: Coroutine resumed

-- Using coroutines with parameters
local function generator()
	local i = 0
	while true do
		i = i + 1
		coroutine.yield(i) -- Yield the next value
	end
end

local gen = coroutine.create(generator)

for _ = 1, 5 do
	local _, value = coroutine.resume(gen)
	print("Generated value:", value)
end

-- Error handling

-- Protected call with pcall
local function unsafeFunction()
	error("An error occurred!")
end

local status, err = pcall(unsafeFunction)
if not status then
	print("Error:", err)
end

-- Object-oriented programming using tables and metatables

-- Define a class using a table and metatable
local Animal = {}
Animal.__index = Animal

function Animal:new(name, sound)
	local obj = setmetatable({}, Animal)
	obj.name = name
	obj.sound = sound
	return obj
end

function Animal:makeSound()
	print(self.name .. " says " .. self.sound)
end

-- Instantiate objects
local dog = Animal:new("Dog", "Woof")
local cat = Animal:new("Cat", "Meow")

dog:makeSound() -- Output: Dog says Woof
cat:makeSound() -- Output: Cat says Meow

-- Modules

-- Define a simple module
local myModule = {}

function myModule.sayHello()
	print("Hello from the module!")
end

return myModule

-- Main script (assuming myModule is in a separate file)
-- local myModule = require("myModule")
-- myModule.sayHello()
