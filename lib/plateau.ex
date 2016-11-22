defmodule Plateau do
  defstruct [:x, :y]

  def create(plateau) do
    {:ok, plateau} = Agent.start_link(fn -> %Plateau{x: plateau.x, y: plateau.y} end)
  end

  def boundaries(plateau) do
    {:ok, boundaries } = get(plateau)
    Map.from_struct boundaries
  end

  def get(plateau) do
    {:ok, Agent.get(plateau, fn plateau -> %Plateau{x: plateau.x, y: plateau.y} end)}
  end
end