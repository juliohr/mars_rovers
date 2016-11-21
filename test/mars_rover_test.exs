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
  		right = -90
			{:ok, rover } = MarsRover.turn(context[:rover], right)
			assert rover == %Rover{ x: 0, y: 0, orientation: "W" }
	  end

	  test "turns left", context do
  		left = 90
			{:ok, rover } = MarsRover.turn(context[:rover], left)
			assert rover == %Rover{ x: 0, y: 0, orientation: "E" }
	  end

	  test "moves forward", context do
			{:ok, rover } = MarsRover.move(context[:rover])
			assert rover == %Rover{ x: 0, y: 1, orientation: "N" }
	  end
  end
end
