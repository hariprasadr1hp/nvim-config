%% Erlang example to test editor settings

%% Define a module and export functions
-module(example).
-export([start/0, add/2, factorial/1, process_message/1]).

%% Start function to run the program
start() ->
    io:format("Hello, Erlang!~n"),

    %% Call add function
    Sum = add(5, 10),
    io:format("Sum of 5 and 10 is: ~p~n", [Sum]),

    %% Call factorial function
    Fact = factorial(5),
    io:format("Factorial of 5 is: ~p~n", [Fact]),

    %% Call process_message function
    process_message({hello, "Erlang"}),
    process_message({goodbye, "Erlang"}).

%% Function to add two numbers
add(A, B) ->
    A + B.

%% Recursive function to calculate factorial
factorial(0) -> 1;
factorial(N) when N > 0 ->
    N * factorial(N - 1).

%% Pattern matching function to process messages
process_message({hello, Name}) ->
    io:format("Received hello message from ~s~n", [Name]);
process_message({goodbye, Name}) ->
    io:format("Received goodbye message from ~s~n", [Name]);
process_message(_) ->
    io:format("Unknown message~n").

%% Simple process with message passing
spawn_process() ->
    Pid = spawn(fun() -> loop() end),
    Pid ! {message, "Hello from a spawned process!"},
    Pid ! stop.

%% Loop function to receive messages
loop() ->
    receive
        {message, Msg} ->
            io:format("Received message: ~s~n", [Msg]),
            loop();
        stop ->
            io:format("Process stopped~n")
    end.

