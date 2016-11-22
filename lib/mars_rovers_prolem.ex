defmodule MarsRoversProblem do
  def main() do
    IO.puts "Reading ./input.txt"
    { :ok, body } = File.read("input.txt")
    IO.puts "Done!"

    split_lines = String.split(body, "\n")
    initialize_plateau(Enum.at(split_lines, 0))

    {:ok, rover1 } = MarsRover.create(Enum.at(split_lines,1))
    instructions_list_rover1 = String.codepoints(Enum.at(split,2))
    Enum.each(instructions_list_rover1, fn instruction -> MarsRover.do(instruction))

    {:ok, rover2 } = MarsRover.create(Enum.at(split_lines,3))
    instructions_list_rover2 = String.codepoints(Enum.at(split,4))
    Enum.each(instructions_list_rover2, fn instruction -> MarsRover.do(instruction))
  end
end