defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  describe "rover" do

  	setup do
  		initial_position = %{x: 0, y: 0, orientation: "N"}
  		{:ok, rover } = MarsRover.create(initial_position)
  		[rover: rover]
  	end

  	test "knows its current position", context do
			assert MarsRover.current_position(context[:rover]) == %{x: 0, y: 0, orientation: "N"}
	  end

	  test "turns right", context do
			{:ok, rover } = MarsRover.turn(context[:rover], "R")
			assert rover == %Rover{ x: 0, y: 0, orientation: "E" }
	  end

	  test "turns left", context do
			{:ok, rover } = MarsRover.turn(context[:rover], "L")
			assert rover == %Rover{ x: 0, y: 0, orientation: "W" }
	  end

	  test "moves forward", context do
			{:ok, rover } = MarsRover.move(context[:rover])
			assert rover == %Rover{ x: 0, y: 1, orientation: "N" }
	  end
  end
end
