defmodule MarsRoverParserTest do
  use ExUnit.Case
  doctest MarsRover

  setup do
      initial_position = %{x: 0, y: 0, orientation: "N"}
      {:ok, rover } = MarsRover.create(initial_position)
      [rover: rover]
  end

  test "executes a turn right command", context do
    MarsRoverParser.execute(context[:rover], "R")
    assert MarsRover.current_position(context[:rover]) == %{ x: 0, y: 0, orientation: "E" }
  end

  test "executes a turn left command", context do
    MarsRoverParser.execute(context[:rover], "L")
    assert MarsRover.current_position(context[:rover]) == %{ x: 0, y: 0, orientation: "W" }
  end

  test "executes a move command", context do
    MarsRoverParser.execute(context[:rover], "M")
    assert MarsRover.current_position(context[:rover]) == %{ x: 0, y: 1, orientation: "N" }
  end
end