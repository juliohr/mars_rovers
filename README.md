# MarsRovers

#### Author: Julio Feijo

### Solution

The solution has three modules:

mars_rover -> responsible for the rover actions turn, move, knows its position
plateau -> a 2d surface with boundaries on x and y
mars_rover_parser -> reads commands from input file and translates to Rover actions

mars_rover_problem generates the program that does the following steps

* reads input file
* creates plateau
* creates rovers
* executes instructions for rover 1
* executes instructions for rover 2
* writes output file

### Installing Elixir

You can skip this if you have Elixir installed on your machine.

If you have homebrew run `$ brew install elixir`

For more options refer to the [Elixir Installation guide](http://elixir-lang.org/install.html)

### How to run

On the root directory execute the following commands

`mix deps.get`
`mix escript.build`
`mix ./mars_rovers`

The answer is on the "output.txt" file on root directory


### Tests

Tests are under the directory tests and can be run with the command `mix test`

you can run a specific test with `mix test test/my_test_path.exs`

### Improvements

* be able to specify input file path
* handle more or less than two rovers (currently it is hard coded to handle only two)
* accept turns different from 90 degrees
* refactor MarsRover.move/2

