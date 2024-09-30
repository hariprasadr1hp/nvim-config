! Fortran 90 example to test editor settings

MODULE math_operations
  ! Public constants
  IMPLICIT NONE
  REAL, PARAMETER :: pi = 3.14159
  INTEGER, PARAMETER :: default_value = 10

CONTAINS
  ! Function to add two integers
  INTEGER FUNCTION add(a, b)
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: a, b
    add = a + b
  END FUNCTION add

  ! Subroutine to print a message
  SUBROUTINE print_message(message)
    IMPLICIT NONE
    CHARACTER(LEN=*), INTENT(IN) :: message
    PRINT *, message
  END SUBROUTINE print_message

  ! Function to calculate the area of a circle
  REAL FUNCTION circle_area(radius)
    IMPLICIT NONE
    REAL, INTENT(IN) :: radius
    circle_area = pi * radius**2
  END FUNCTION circle_area
END MODULE math_operations


PROGRAM main
  USE math_operations
  IMPLICIT NONE
  
  ! Variable declarations
  INTEGER :: x, y, sum_result
  REAL :: radius, area

  ! Assign values to variables
  x = 5
  y = 7
  radius = 3.0

  ! Call the add function
  sum_result = add(x, y)
  PRINT *, "The sum of ", x, " and ", y, " is: ", sum_result

  ! Call the circle_area function
  area = circle_area(radius)
  PRINT *, "The area of a circle with radius ", radius, " is: ", area

  ! Call a subroutine to print a message
  CALL print_message("This is a message from the subroutine!")

  ! Demonstrate conditional statements
  IF (x > y) THEN
    PRINT *, x, " is greater than ", y
  ELSE IF (x == y) THEN
    PRINT *, x, " is equal to ", y
  ELSE
    PRINT *, x, " is less than ", y
  END IF

  ! Demonstrate a loop
  PRINT *, "Counting from 1 to 5:"
  DO x = 1, 5
    PRINT *, x
  END DO

  ! Demonstrate array handling
  CALL array_example()

  ! Demonstrate recursion
  PRINT *, "Factorial of 5 is: ", factorial(5)

END PROGRAM main


SUBROUTINE array_example()
  IMPLICIT NONE
  INTEGER, DIMENSION(5) :: arr
  INTEGER :: i

  ! Assign values to an array and print them
  DO i = 1, 5
    arr(i) = i * 2
  END DO

  PRINT *, "Array values:"
  DO i = 1, 5
    PRINT *, "arr(", i, ") = ", arr(i)
  END DO
END SUBROUTINE array_example


RECURSIVE FUNCTION factorial(n) RESULT(fact)
  IMPLICIT NONE
  INTEGER, INTENT(IN) :: n
  INTEGER :: fact

  ! Base case
  IF (n == 0) THEN
    fact = 1
  ELSE
    ! Recursive case
    fact = n * factorial(n - 1)
  END IF
END FUNCTION factorial

