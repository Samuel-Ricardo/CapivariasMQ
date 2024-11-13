defmodule CapivariasmqTest do
  use ExUnit.Case
  doctest Capivariasmq

  test "greets the world" do
    assert Capivariasmq.hello() == :world
  end

  test "main" do
    Capivariasmq.main()
  end
end
