(* OCaml example to test editor settings *)

(* Variables and basic types *)
let name = "OCaml"
let age = 25
let is_active = true

(* Print a message *)
print_endline ("Hello, " ^ name ^ "!")

(* Function to add two numbers *)
let add a b = a + b

(* Call the function *)
let result = add 5 10
let () = Printf.printf "Addition result: %d\n" result

(* Conditional statements *)
if age > 30 then
  print_endline "Age is greater than 30"
else
  print_endline "Age is less than or equal to 30"

(* Lists *)
let numbers = [1; 2; 3; 4; 5]

(* Pattern matching with lists *)
let rec print_numbers = function
  | [] -> ()
  | head :: tail ->
      Printf.printf "Number: %d\n" head;
      print_numbers tail

let () = print_numbers numbers

(* Tuples *)
let person = ("Alice", 28)

let (name, age) = person
let () = Printf.printf "Name: %s, Age: %d\n" name age

(* Option type *)
let find_index lst target =
  let rec aux lst idx =
    match lst with
    | [] -> None
    | h :: t -> if h = target then Some idx else aux t (idx + 1)
  in
  aux lst 0

let index = find_index numbers 3
let () =
  match index with
  | Some idx -> Printf.printf "Found at index: %d\n" idx
  | None -> print_endline "Value not found"

(* Define a record *)
type person = {
  name : string;
  age : int;
}

let person1 = { name = "Bob"; age = 35 }
let () = Printf.printf "Person: %s, Age: %d\n" person1.name person1.age

(* Recursion: Factorial function *)
let rec factorial n =
  if n = 0 then 1 else n * factorial (n - 1)

let () = Printf.printf "Factorial of 5: %d\n" (factorial 5)

(* Higher-order function *)
let apply_twice f x = f (f x)
let double x = x * 2
let result = apply_twice double 5
let () = Printf.printf "Result after applying twice: %d\n" result

