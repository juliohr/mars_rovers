defmodule MarsRoverParser do
  def execute(rover, plateau, command) do
    case command do
      "L" -> MarsRover.turn(rover, "L"); :ok
      "R" -> MarsRover.turn(rover, "R"); :ok
      "M" -> MarsRover.move(rover, Plateau.boundaries(plateau)); :ok
      _ -> {:error, "Invalid Command"}
    end
  end
end