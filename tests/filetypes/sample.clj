;; Clojure example to test editor settings

;; Define variables and constants
(def name "Clojure")
(def version 1.10)

;; Print a message
(println (str "Hello, " name "! Version: " version))

;; Define a function to add two numbers
(defn add [a b]
  (+ a b))

;; Call the function
(def result (add 5 10))
(println "Sum of 5 and 10:" result)

;; Conditional statement
(if (> result 10)
  (println "Result is greater than 10")
  (println "Result is less than or equal to 10"))

;; Looping through a collection
(def numbers [1 2 3 4 5])
(doseq [num numbers]
  (println "Number:" num))

;; Define a map (similar to a dictionary)
(def person {:name "Alice" :age 30 :email "alice@example.com"})
(println (:name person) "is" (:age person) "years old.")

;; Define a simple record (Java-style class)
(defrecord Person [name age])

;; Create an instance of the record and call the method
(def person1 (->Person "Bob" 35))
(println "Hello, my name is" (:name person1) "and I am" (:age person1) "years old.")

;; Define a recursive function (factorial)
(defn factorial [n]
  (if (zero? n)
    1
    (* n (factorial (dec n)))))

(println "Factorial of 5:" (factorial 5))

;; Lambda expression (anonymous function)
(def square #(Math/pow % 2))
(println "Square of 4:" (square 4))

;; Error handling with try-catch
(defn fetch-data [url]
  (if (empty? url)
    (throw (Exception. "URL cannot be empty"))
    (println "Fetching data from" url)))

(try
  (fetch-data "")
  (catch Exception e
    (println "Error fetching data:" (.getMessage e))))

