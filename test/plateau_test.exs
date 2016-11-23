defmodule PlateauTest do
  use ExUnit.Case

  @boundaries %{x: 2, y: 2}

  setup do
    {:ok, plateau} = Plateau.create(@boundaries)
    [plateau: plateau]  
  end

  test "creates a Plateau" do
    assert {:ok, plateau} = Plateau.create(%{x: 2, y: 2})
  end

  test "gets a Plateau", context do
    assert {:ok, plateau} = Plateau.get(context[:plateau])
    assert plateau == %Plateau{x: 2, y: 2}
  end

  test "gets Plateau's boundaries", context do
    assert Plateau.boundaries(context[:plateau]) == @boundaries
  end
end