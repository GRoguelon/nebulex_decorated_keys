defmodule NebulexDecoratedKeysTest do
  use ExUnit.Case

  test "greets the world" do
    assert NebulexDecoratedKeys.hello("Jane") == "Hello, Jane!"
    assert NebulexDecoratedKeys.hello("John") == "Hello, John!"
  end
end
