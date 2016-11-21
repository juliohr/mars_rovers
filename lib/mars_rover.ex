defmodule MarsRover do

	def create(rover) do
		{ :ok, rover } = Agent.start_link(fn -> %Rover{ x: rover.x, y: rover.y, orientation: rover.orientation} end)
	end

	def current_position(rover) do
		Agent.get(rover, fn rover ->
			%{ x: rover.x, y: rover.y, orientation: rover.orientation } 
		end)
	end
end
