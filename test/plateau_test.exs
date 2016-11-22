defmodule PlateauTest do
  use ExUnit.Case

  test "creates a Plateau" do
    assert {:ok, plateau} = Plateau.create(%{x: 2, y: 2})
  end

  test "gets a Plateau" do
    {:ok, plateau} = Plateau.create(%{x: 2, y: 2})
    assert {:ok, plateau} = Plateau.get(plateau)
    assert plateau == %Plateau{x: 2, y: 2}
  end
end