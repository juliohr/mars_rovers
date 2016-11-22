defmodule MarsRover do
  def create(rover) do
    { :ok, rover } = Agent.start_link(fn -> %Rover{ x: rover.x, y: rover.y, orientation: rover.orientation} end)
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
      {"E", "L"} -> Agent.update(rover, fn rover -> %{rover | orientation: "S" } end) 
      {"E", "R"} -> Agent.update(rover, fn rover -> %{rover | orientation: "N" } end) 
      {"S", "L"} -> Agent.update(rover, fn rover -> %{rover | orientation: "E" } end) 
      {"S", "R"} -> Agent.update(rover, fn rover -> %{rover | orientation: "W" } end) 
      {"W", "L"} -> Agent.update(rover, fn rover -> %{rover | orientation: "S" } end) 
      {"W", "R"} -> Agent.update(rover, fn rover -> %{rover | orientation: "N" } end) 
    end
    {:ok, Agent.get(rover, fn rover -> rover end)}
  end

  def move(rover) do
    current_position = current_position(rover)
    case current_position.orientation do
      "N" -> Agent.update(rover, fn rover -> %{rover | y: (rover.y + 1) } end) 
      "E" -> Agent.update(rover, fn rover -> %{rover | y: (rover.x + 1) } end) 
      "S" -> Agent.update(rover, fn rover -> %{rover | y: (rover.y - 1) } end) 
      "W" -> Agent.update(rover, fn rover -> %{rover | y: (rover.x - 1) } end) 
    end
    {:ok, Agent.get(rover, fn rover -> rover end)}
  end
end
