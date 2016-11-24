defmodule MarsRoverParserTest do
  use ExUnit.Case, async: false
  doctest MarsRover

  import Mock

  @rover_position %{x: 0, y: 0, orientation: "N"}
  @plateau_boundaries %{x: 2, y: 2}

  setup do
      {:ok, plateau} = Plateau.create(@plateau_boundaries)
      {:ok, rover } = MarsRover.create(@rover_position, Plateau.boundaries(plateau))
      [rover: rover, plateau: plateau]
  end

  test "executes a turn right command", context do
    with_mock MarsRover, [turn: fn(_rover, _command) -> :ok end] do
      assert :ok = MarsRoverParser.execute(context[:rover], context[:plateau], "R")
      assert called MarsRover.turn(context[:rover], "R")
    end
  end

  test "executes a turn left command", context do
    with_mock MarsRover, [turn: fn(_rover, _command) -> :ok end] do
      assert :ok = MarsRoverParser.execute(context[:rover], context[:plateau], "L")
      assert called MarsRover.turn(context[:rover], "L")
    end
  end

  test "executes a move command", context do
    with_mocks([
      {MarsRover,[],[move: fn(_rover, _boundaries) -> :ok end ]},
      {Plateau, [], [boundaries: fn(_plateau) -> @plateau_boundaries end ]}]) do

      assert :ok = MarsRoverParser.execute(context[:rover], context[:plateau], "M")
      assert called MarsRover.move(context[:rover], @plateau_boundaries)
    end
  end

  test "show an error when invalid command", context do
    assert {:error, msg} = MarsRoverParser.execute(context[:rover], context[:plateau], "E")
    assert msg == "Invalid Command"
  end
end