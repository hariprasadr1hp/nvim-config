;; Emacs Lisp (Elisp) example to test editor settings

;; Define a variable
(setq name "Emacs Lisp")
(setq age 30)

;; Print a message to the minibuffer
(message "Hello, %s!" name)

;; Define a function to add two numbers
(defun add (a b)
  "Add two numbers A and B."
  (+ a b))

;; Call the function and display the result
(let ((result (add 5 10)))
  (message "Addition result: %d" result))

;; Conditional statements
(if (> age 25)
    (message "Age is greater than 25")
  (message "Age is less than or equal to 25"))

;; Loops

;; For loop equivalent using `dotimes`
(dotimes (i 5)
  (message "Dotimes loop iteration: %d" i))

;; While loop
(setq i 1)
(while (<= i 5)
  (message "While loop iteration: %d" i)
  (setq i (1+ i)))

;; Working with lists
(setq numbers '(1 2 3 4 5))

;; Iterating over a list with `dolist`
(dolist (num numbers)
  (message "Number: %d" num))

;; Define a keybinding for a custom function
(defun my-greeting ()
  "Display a greeting message."
  (interactive)
  (message "Hello from my-greeting function!"))

;; Assign the function to a key
(global-set-key (kbd "C-c g") 'my-greeting)

;; Define a recursive function (factorial)
(defun factorial (n)
  "Return the factorial of N."
  (if (= n 0)
      1
    (* n (factorial (1- n)))))

(message "Factorial of 5: %d" (factorial 5))

;; Error handling using `condition-case`
(condition-case err
    (progn
      ;; Simulate an error by dividing by zero
      (/ 1 0))
  (arith-error
   (message "Caught arithmetic error: %s" err)))

;; File I/O example
(with-temp-buffer
  (insert "This is a test file written in Emacs Lisp.\n")
  (write-file "test-file.txt"))

;; Read and print the contents of the file
(with-temp-buffer
  (insert-file-contents "test-file.txt")
  (message "File contents: %s" (buffer-string)))

