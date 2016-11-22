defmodule MarsRoversProblem do
  def main(args) do
    IO.puts "Reading ./input.txt"
    { :ok, body } = File.read("input.txt")
    IO.puts "Done!"

    split_lines = String.split(body, "\n")

    command_rover_fn = fn (rover) -> fn (instruction) -> MarsRoverParser.execute(rover, instruction) end end


    rover1_list = String.split(Enum.at(split_lines,1), " ")
    rover1_initial_value = %{ x: String.to_integer(Enum.at(rover1_list, 0)), y: String.to_integer(Enum.at(rover1_list, 1)), orientation: Enum.at(rover1_list, 2) }
    {:ok, rover1 } = MarsRover.create(rover1_initial_value)
    instructions_list_rover1 = String.codepoints(Enum.at(split_lines,2))
    command_rover1 = command_rover_fn.(rover1)
    Enum.each(instructions_list_rover1, fn instruction -> command_rover1.(instruction) end)

    rover2_list = String.split(Enum.at(split_lines,3), " ")
    rover2_initial_value = %{ x: String.to_integer(Enum.at(rover2_list, 0)), y: String.to_integer(Enum.at(rover2_list, 1)), orientation: Enum.at(rover2_list, 2) }
    {:ok, rover2 } = MarsRover.create(rover2_initial_value)
    instructions_list_rover1 = String.codepoints(Enum.at(split_lines,4))
    command_rover1 = command_rover_fn.(rover2)
    Enum.each(instructions_list_rover1, fn instruction -> command_rover1.(instruction) end)

    IO.inspect MarsRover.current_position(rover1)
    IO.inspect MarsRover.current_position(rover2)
  end
end