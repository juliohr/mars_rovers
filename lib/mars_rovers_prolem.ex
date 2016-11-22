defmodule MarsRoversProblem do
  def main(args) do
    IO.puts "Reading input file"
    { :ok, body } = File.read("input.txt")

    IO.puts "Creating Plateau"
    {:ok, plateau} = Plateau.create(parse_plateau_boundaries(body,0))
    boundaries = Plateau.boundaries(plateau)

    IO.puts "Creating rovers"
    {:ok, rover1 } = MarsRover.create(parse_initial_position(body, 1), boundaries)
    {:ok, rover2 } = MarsRover.create(parse_initial_position(body, 3), boundaries)

    IO.puts "Executing instructions for rover 1"
    command_rover1 = generate_command_rover_fn(rover1)
    Enum.each(instructions_on_line(body, 2), fn instruction -> command_rover1.(instruction) end)

    IO.puts "Executing instructions for rover 2"
    command_rover2 = generate_command_rover_fn(rover2)
    Enum.each(instructions_on_line(body, 4), fn instruction -> command_rover2.(instruction) end)

    IO.puts "Writing output file to 'output.txt'"
    write_output_file([MarsRover.current_position(rover1),
                       MarsRover.current_position(rover2)
                      ])
    IO.puts "Done"
  end

  defp parse_initial_position(body, line) do
    split_lines = String.split(body, "\n")
    input_list = String.split(Enum.at(split_lines,line), " ")
    %{ x: String.to_integer(Enum.at(input_list, 0)), y: String.to_integer(Enum.at(input_list, 1)), orientation: Enum.at(input_list, 2) }
  end

  defp parse_plateau_boundaries(body, line) do
    split_lines = String.split(body, "\n")
    input_list = String.split(Enum.at(split_lines,line), " ")
    %{ x: String.to_integer(Enum.at(input_list, 0)), y: String.to_integer(Enum.at(input_list, 1))}
  end

  """
  This function receives a rover process pid as a parameter
  and returns a function that execute instructions for 
  the given rover
  """
  defp generate_command_rover_fn(rover) do
    fn (instruction) -> MarsRoverParser.execute(rover, instruction) end
  end

  defp instructions_on_line(body, line) do
    String.codepoints(Enum.at(String.split(body, "\n"),line))
  end

  defp write_output_file(rover_list) do
    {:ok, file} = File.open("output.txt", [:write])
    Enum.each(rover_list, fn rover -> 
      IO.write(file, Integer.to_string(rover.x) <> " " <>
                     Integer.to_string(rover.y) <> " " <>
                     rover.orientation <> "\n"
              )
    end)
    File.close file
  end
end