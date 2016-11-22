defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  describe "rover creation" do
    test "creates rover successfuly with valid attributes" do
      initial_position = %{x: 0, y: 0, orientation: "N"}
      boundaries = %Plateau{x: 2, y: 2}
      assert {:ok, rover } = MarsRover.create(initial_position, boundaries)  
    end

    test "cannot create rover with negative position on x" do
      initial_position = %{x: -1, y: 0, orientation: "N"}
      boundaries = %Plateau{x: 2, y: 2}
      assert {:error, msg } = MarsRover.create(initial_position, boundaries)
      assert msg == "Rover's x position is outside plateau's boundaries"
    end

    test "cannot create rover with negative position on y" do
      initial_position = %{x: 0, y: -1, orientation: "N"}
      boundaries = %Plateau{x: 2, y: 2}
      assert {:error, msg } = MarsRover.create(initial_position, boundaries)
      assert msg == "Rover's y position is outside plateau's boundaries"
    end

    test "cannot create rover outside plateau's x boundaries" do
      initial_position = %{x: 4, y: 0, orientation: "N"}
      boundaries = %Plateau{x: 2, y: 2}
      {:error, rover } = MarsRover.create(initial_position, boundaries)
      assert {:error, msg } = MarsRover.create(initial_position, boundaries)
      assert msg == "Rover's x position is outside plateau's boundaries"
    end

    test "cannot create rover outside plateau's y boundaries" do
      initial_position = %{x: 0, y: 3, orientation: "N"}
      boundaries = %Plateau{x: 2, y: 2}
      {:error, rover } = MarsRover.create(initial_position, boundaries)
      assert {:error, msg } = MarsRover.create(initial_position, boundaries)
      assert msg == "Rover's y position is outside plateau's boundaries"
    end
  end

  test "rover cannot move outside boundaries" do
    initial_position = %{x: 0, y: 2, orientation: "N"}
    {:ok, plateau} = Plateau.create(%{x: 2, y: 2})
    {:ok, rover } = MarsRover.create(initial_position, Plateau.boundaries(plateau))
    assert { :error, msg } = MarsRover.move(rover, Plateau.boundaries(plateau))
    assert msg == "Cannot move outside boundaries"
  end

  describe "rover oriented towards north" do
    setup do
      initial_position = %{x: 0, y: 0, orientation: "N"}
      {:ok, plateau} = Plateau.create(%{x: 2, y: 2})
      boundaries = Plateau.boundaries(plateau)
      {:ok, rover } = MarsRover.create(initial_position, boundaries)
      [rover: rover, boundaries: boundaries]
    end

    test "knows its current position", context do
      assert MarsRover.current_position(context[:rover]) == %{x: 0, y: 0, orientation: "N"}
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %MarsRover{ x: 0, y: 0, orientation: "E" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %MarsRover{ x: 0, y: 0, orientation: "W" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover], context[:boundaries])
      assert rover == %MarsRover{ x: 0, y: 1, orientation: "N" }
    end
  end

  describe "rover oriented towards east" do
    setup do
      initial_position = %{x: 0, y: 0, orientation: "E"}
      {:ok, plateau} = Plateau.create(%{x: 2, y: 2})
      boundaries = Plateau.boundaries(plateau)
      {:ok, rover } = MarsRover.create(initial_position, boundaries)
      [rover: rover, boundaries: boundaries]
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %MarsRover{ x: 0, y: 0, orientation: "S" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %MarsRover{ x: 0, y: 0, orientation: "N" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover], context[:boundaries])
      assert rover == %MarsRover{ x: 1, y: 0, orientation: "E" }
    end
  end

  describe "rover oriented towards south" do
    setup do
      initial_position = %{x: 0, y: 1, orientation: "S"}
      {:ok, plateau} = Plateau.create(%{x: 2, y: 2})
      boundaries = Plateau.boundaries(plateau)
      {:ok, rover } = MarsRover.create(initial_position, boundaries)
      [rover: rover, boundaries: boundaries]
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %MarsRover{ x: 0, y: 1, orientation: "W" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %MarsRover{ x: 0, y: 1, orientation: "E" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover], context[:boundaries])
      assert rover == %MarsRover{ x: 0, y: 0, orientation: "S" }
    end
  end

  describe "rover oriented towards W" do
    setup do
      initial_position = %{x: 1, y: 0, orientation: "W"}
      {:ok, plateau} = Plateau.create(%{x: 2, y: 2})
      boundaries = Plateau.boundaries(plateau)
      {:ok, rover } = MarsRover.create(initial_position, boundaries)
      [rover: rover, boundaries: boundaries]
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %MarsRover{ x: 1, y: 0, orientation: "N" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %MarsRover{ x: 1, y: 0, orientation: "S" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover], context[:boundaries])
      assert rover == %MarsRover{ x: 0, y: 0, orientation: "W" }
    end
  end
end
