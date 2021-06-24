defmodule WeatherlixirTest do
  use ExUnit.Case
  doctest Weatherlixir

  test "greets the world" do
    assert Weatherlixir.hello() == :world
  end
end
