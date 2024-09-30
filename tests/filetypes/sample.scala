// Scala example to test editor settings

// Define an object with a main method
object Example {
  def main(args: Array[String]): Unit = {
    println("Hello, Scala!")

    // Call add function
    val sum = add(5, 10)
    println(s"Sum of 5 and 10: $sum")

    // Call factorial function
    val fact = factorial(5)
    println(s"Factorial of 5: $fact")

    // Call processMessage function
    processMessage(("hello", "Scala"))
    processMessage(("goodbye", "Scala"))

    // Call spawnProcess example
    spawnProcess()
  }

  // Function to add two numbers
  def add(a: Int, b: Int): Int = a + b

  // Recursive function to calculate factorial
  def factorial(n: Int): Int = {
    if (n == 0) 1 else n * factorial(n - 1)
  }

  // Pattern matching example with tuples
  def processMessage(msg: (String, String)): Unit = msg match {
    case ("hello", name) => println(s"Received a hello message from $name")
    case ("goodbye", name) => println(s"Received a goodbye message from $name")
    case _ => println("Unknown message")
  }

  // Simple process simulation (like threads)
  def spawnProcess(): Unit = {
    val thread = new Thread(new Runnable {
      def run(): Unit = {
        for (i <- 1 to 5) {
          println(s"Thread message: $i")
          Thread.sleep(500)
        }
        println("Thread finished.")
      }
    })
    thread.start()
  }
}

