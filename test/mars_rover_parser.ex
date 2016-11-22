defmodule MarsRoverParserTest do
  use ExUnit.Case
  doctest MarsRover

  setup do
      initial_position = %{x: 0, y: 0, orientation: "N"}
      {:ok, rover } = MarsRover.create(initial_position)
      [rover: rover]
  end

  test "executes a turn right command" do
    MarsRoverParser.execute(rover, "R")
    assert MarsRover.current_position(rover) == %{ x: 0, y: 0, orientation: "W" }
  end

  test "executes a turn left command" do
    MarsRoverParser.execute(rover, "L")
    assert MarsRover.current_position(rover) == %{ x: 0, y: 0, orientation: "E" }
  end

  test "executes a move command" do
    MarsRoverParser.execute(rover, "M")
    assert MarsRover.current_position(rover) == %{ x: 0, y: 1, orientation: "N" }
  end