defmodule MarsRover do
  defstruct [:x, :y, :orientation]

  def create(rover, plateau) do
    cond do
      rover.x < 0 ||rover.x > plateau.x ->
        {:error, "Rover's x position is outside plateau's boundaries" }
      rover.y < 0 || rover.y > plateau.y ->
        {:error, "Rover's y position is outside plateau's boundaries" }
      true ->
        Agent.start_link(fn -> %MarsRover{ x: rover.x, y: rover.y, orientation: rover.orientation} end)
    end
  end

  def current_position(rover) do
    Agent.get(rover, fn rover ->
      %{ x: rover.x, y: rover.y, orientation: rover.orientation } 
    end)
  end

  def turn(rover, rotation) do
    current_position = current_position(rover)
    case {current_position.orientation, rotation } do
      {"N", "L"} -> Agent.update(rover, fn rover -> %{rover | orientation: "W" } end) 
      {"N", "R"} -> Agent.update(rover, fn rover -> %{rover | orientation: "E" } end) 
      {"E", "L"} -> Agent.update(rover, fn rover -> %{rover | orientation: "N" } end) 
      {"E", "R"} -> Agent.update(rover, fn rover -> %{rover | orientation: "S" } end) 
      {"S", "L"} -> Agent.update(rover, fn rover -> %{rover | orientation: "E" } end) 
      {"S", "R"} -> Agent.update(rover, fn rover -> %{rover | orientation: "W" } end) 
      {"W", "L"} -> Agent.update(rover, fn rover -> %{rover | orientation: "S" } end) 
      {"W", "R"} -> Agent.update(rover, fn rover -> %{rover | orientation: "N" } end) 
    end
    {:ok, Agent.get(rover, fn rover -> rover end)}
  end

  def move(rover, boundaries) do
    rover_position = current_position(rover)
    case rover_position.orientation do
      "N" -> 
        unless rover_position.y == boundaries.y do
          Agent.update(rover, fn rover -> %{rover | y: (rover.y + 1) } end)
          {:ok, Agent.get(rover, fn rover -> rover end)}
        else
          {:error, "Cannot move outside boundaries"}
        end
      "E" ->
        unless rover_position.x == boundaries.x do
          Agent.update(rover, fn rover -> %{rover | x: (rover.x + 1) } end) 
          {:ok, Agent.get(rover, fn rover -> rover end)}
        else
          {:error, "Cannot move outside boundaries"}
        end
      "S" ->
        unless rover_position.y == 0 do
          Agent.update(rover, fn rover -> %{rover | y: (rover.y - 1) } end) 
          {:ok, Agent.get(rover, fn rover -> rover end)}
        else
          {:error, "Cannot move outside boundaries"}
        end
      "W" -> 
        unless rover_position.x == 0 do
          Agent.update(rover, fn rover -> %{rover | x: (rover.x - 1) } end) 
          {:ok, Agent.get(rover, fn rover -> rover end)}
        else
          {:error, "Cannot move outside boundaries"}
        end
    end
  end
end
