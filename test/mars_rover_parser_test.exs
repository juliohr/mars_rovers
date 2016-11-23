defmodule MarsRoverParserTest do
  use ExUnit.Case
  doctest MarsRover

  @rover_position %{x: 0, y: 0, orientation: "N"}
  @plateau_boundaries %{x: 2, y: 2}

  setup do
      {:ok, plateau} = Plateau.create(@plateau_boundaries)
      {:ok, rover } = MarsRover.create(@rover_position, Plateau.boundaries(plateau))
      [rover: rover, plateau: plateau]
  end

  test "executes a turn right command", context do
    assert :ok = MarsRoverParser.execute(context[:rover], context[:plateau], "R")
    assert MarsRover.current_position(context[:rover]) == %{ x: 0, y: 0, orientation: "E" }
  end

  test "executes a turn left command", context do
    assert :ok = MarsRoverParser.execute(context[:rover], context[:plateau], "L")
    assert MarsRover.current_position(context[:rover]) == %{ x: 0, y: 0, orientation: "W" }
  end

  test "executes a move command", context do
    assert :ok = MarsRoverParser.execute(context[:rover], context[:plateau], "M")
    assert MarsRover.current_position(context[:rover]) == %{ x: 0, y: 1, orientation: "N" }
  end

  test "show an error when invalid command", context do
    assert {:error, msg} = MarsRoverParser.execute(context[:rover], context[:plateau], "E")
    assert msg == "Invalid Command"
  end
end