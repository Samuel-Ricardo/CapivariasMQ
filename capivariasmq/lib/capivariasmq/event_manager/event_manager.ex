defmodule EventManager do
  # alias ExUnit.EventManager

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state), do: {:ok, state}
end
