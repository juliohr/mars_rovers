defmodule MarsRoverParser do
  def execute(rover, plateau, command) do
    case command do
      "L" -> MarsRover.turn(rover, "L")
      "R" -> MarsRover.turn(rover, "R")
      "M" -> MarsRover.move(rover, Plateau.boundaries(plateau))
    end
  end
end