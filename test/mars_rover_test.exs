defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  test "rover cannot move outside boundaries" do
    initial_position = %{x: 0, y: 0, orientation: "N"}
    boundaries = %Plateau{x: 2, y: 2}
    {:ok, rover } = MarsRover.create(initial_position, boundaries)
    { :error, rover } = MarsRover.move(rover)
    assert rover == %Rover{ x: 0, y: 0, orientation: "W" }
  end

  describe "rover oriented towards north" do
    setup do
      initial_position = %{x: 0, y: 0, orientation: "N"}
      boundaries = %Plateau{x: 2, y: 2}
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

  describe "rover oriented towards east" do
    setup do
      initial_position = %{x: 0, y: 0, orientation: "E"}
      {:ok, rover } = MarsRover.create(initial_position)
      [rover: rover]
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %Rover{ x: 0, y: 0, orientation: "S" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %Rover{ x: 0, y: 0, orientation: "N" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover])
      assert rover == %Rover{ x: 1, y: 0, orientation: "E" }
    end
  end

  describe "rover oriented towards south" do
    setup do
      initial_position = %{x: 0, y: 1, orientation: "S"}
      {:ok, rover } = MarsRover.create(initial_position)
      [rover: rover]
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %Rover{ x: 0, y: 1, orientation: "W" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %Rover{ x: 0, y: 1, orientation: "E" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover])
      assert rover == %Rover{ x: 0, y: 0, orientation: "S" }
    end
  end

  describe "rover oriented towards W" do
    setup do
      initial_position = %{x: 1, y: 0, orientation: "W"}
      {:ok, rover } = MarsRover.create(initial_position)
      [rover: rover]
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %Rover{ x: 1, y: 0, orientation: "N" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %Rover{ x: 1, y: 0, orientation: "S" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover])
      assert rover == %Rover{ x: 0, y: 0, orientation: "W" }
    end
  end
end
