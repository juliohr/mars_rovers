defmodule MarsRoverParser do
  def execute(rover, command) do
    case command do
      "L" -> MarsRover.turn(rover, "L")
      "R" -> MarsRover.turn(rover, "R")
      "M" -> MarsRover.move(rover)
    end
  end
end