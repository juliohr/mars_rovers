defmodule MarsRoversProblem do
  def main() do
    IO.puts "Reading ./input.txt"
    { :ok, body } = File.read("input.txt")
    IO.puts "Done!"

    split_lines = String.split(body, "\n")

    command_rover_fn = fn (rover) -> fn (instruction) -> MarsRoverParser.execute(rover, instruction) end end

    {:ok, rover1 } = MarsRover.create(Enum.at(split_lines,1))
    instructions_list_rover1 = String.codepoints(Enum.at(split_lines,2))
    command_rover1 = command_rover_fn.(rover1)
    Enum.each(instructions_list_rover1, fn instruction -> command_rover1.(instruction) end)

    {:ok, rover2 } = MarsRover.create(Enum.at(split_lines,3))
    instructions_list_rover2 = String.codepoints(Enum.at(split_lines,4))
    command_rover2 = command_rover_fn.(rover2)

    Enum.each(instructions_list_rover2, fn instruction -> command_rover2.(instruction) end)
  end
end