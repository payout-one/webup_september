defmodule SeptemberTest do
  use ExUnit.Case
  doctest September

  test "greets the world" do
    assert September.hello() == :world
  end
end
