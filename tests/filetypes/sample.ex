# Elixir example to test editor settings

# Define a module
defmodule Example do
  # Public function to start the program
  def start do
    IO.puts("Hello, Elixir!")

    # Call add function
    sum = add(5, 10)
    IO.puts("Sum of 5 and 10: #{sum}")

    # Call factorial function
    fact = factorial(5)
    IO.puts("Factorial of 5: #{fact}")

    # Call process_message function
    process_message({:hello, "Elixir"})
    process_message({:goodbye, "Elixir"})
  end

  # Function to add two numbers
  def add(a, b) do
    a + b
  end

  # Recursive function to calculate factorial
  def factorial(0), do: 1
  def factorial(n), do: n * factorial(n - 1)

  # Pattern matching function to process messages
  def process_message({:hello, name}) do
    IO.puts("Received a hello message from #{name}")
  end

  def process_message({:goodbye, name}) do
    IO.puts("Received a goodbye message from #{name}")
  end

  def process_message(_other) do
    IO.puts("Unknown message")
  end
end

# Example of starting a simple process
defmodule ExampleProcess do
  def spawn_process do
    spawn(fn -> loop() end)
  end

  def loop do
    receive do
      {:message, msg} ->
        IO.puts("Received message: #{msg}")
        loop()

      :stop ->
        IO.puts("Process stopped")
    end
  end
end

# Start the program
Example.start()

# Spawn a process and send messages
pid = ExampleProcess.spawn_process()
send(pid, {:message, "Hello from a spawned process!"})
send(pid, :stop)

