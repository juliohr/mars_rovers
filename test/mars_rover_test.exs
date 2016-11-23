defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  @boundaries %Plateau{x: 2, y: 2}
  @valid_with_orientation_n %{x: 1, y: 1, orientation: "N"}
  @valid_with_orientation_e %{x: 1, y: 1, orientation: "E"}
  @valid_with_orientation_s %{x: 1, y: 1, orientation: "S"}
  @valid_with_orientation_w %{x: 1, y: 1, orientation: "W"}
  @valid_with_y_on_boundary %{x: 1, y: 2, orientation: "N"}
  @invalid_neg_x %{x: -1, y: 0, orientation: "N"}
  @invalid_neg_y %{x: 0, y: -1, orientation: "N"}
  @invalid_out_x %{x: 4, y: 0, orientation: "N"}
  @invalid_out_y %{x: 0, y: 4, orientation: "N"}

  describe "rover creation" do
    test "creates rover successfuly with valid attributes" do
      assert {:ok, rover } = MarsRover.create(@valid_with_orientation_n, @boundaries)  
    end

    test "cannot create rover with negative position on x" do
      assert {:error, msg } = MarsRover.create(@invalid_neg_x, @boundaries)
      assert msg == "Rover's x position is outside plateau's boundaries"
    end

    test "cannot create rover with negative position on y" do
      assert {:error, msg } = MarsRover.create(@invalid_neg_y, @boundaries)
      assert msg == "Rover's y position is outside plateau's boundaries"
    end

    test "cannot create rover outside plateau's x boundaries" do
      assert {:error, msg } = MarsRover.create(@invalid_out_x, @boundaries)
      assert msg == "Rover's x position is outside plateau's boundaries"
    end

    test "cannot create rover outside plateau's y boundaries" do
      assert {:error, msg } = MarsRover.create(@invalid_out_y, @boundaries)
      assert msg == "Rover's y position is outside plateau's boundaries"
    end
  end

  test "rover cannot move outside boundaries" do
    {:ok, rover } = MarsRover.create(@valid_with_y_on_boundary, @boundaries)
    assert { :error, msg } = MarsRover.move(rover, @boundaries)
    assert msg == "Cannot move outside boundaries"
  end

  describe "rover oriented towards north" do
    setup do
      {:ok, rover } = MarsRover.create(@valid_with_orientation_n, @boundaries)
      [rover: rover]
    end

    test "knows its current position", context do
      assert MarsRover.current_position(context[:rover]) == %{x: 1, y: 1, orientation: "N"}
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %MarsRover{ x: 1, y: 1, orientation: "E" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %MarsRover{ x: 1, y: 1, orientation: "W" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover], @boundaries)
      assert rover == %MarsRover{ x: 1, y: 2, orientation: "N" }
    end
  end

  describe "rover oriented towards east" do
    setup do
      {:ok, rover } = MarsRover.create(@valid_with_orientation_e, @boundaries)
      [rover: rover]
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %MarsRover{ x: 1, y: 1, orientation: "S" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %MarsRover{ x: 1, y: 1, orientation: "N" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover], @boundaries)
      assert rover == %MarsRover{ x: 2, y: 1, orientation: "E" }
    end
  end

  describe "rover oriented towards south" do
    setup do
      {:ok, rover } = MarsRover.create(@valid_with_orientation_s, @boundaries)
      [rover: rover]
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %MarsRover{ x: 1, y: 1, orientation: "W" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %MarsRover{ x: 1, y: 1, orientation: "E" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover], @boundaries)
      assert rover == %MarsRover{ x: 1, y: 0, orientation: "S" }
    end
  end

  describe "rover oriented towards W" do
    setup do
      {:ok, rover } = MarsRover.create(@valid_with_orientation_w, @boundaries)
      [rover: rover]
    end

    test "turns right", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "R")
      assert rover == %MarsRover{ x: 1, y: 1, orientation: "N" }
    end

    test "turns left", context do
      {:ok, rover } = MarsRover.turn(context[:rover], "L")
      assert rover == %MarsRover{ x: 1, y: 1, orientation: "S" }
    end

    test "moves forward", context do
      {:ok, rover } = MarsRover.move(context[:rover], @boundaries)
      assert rover == %MarsRover{ x: 0, y: 1, orientation: "W" }
    end
  end
end
