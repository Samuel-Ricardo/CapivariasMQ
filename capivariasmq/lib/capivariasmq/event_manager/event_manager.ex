defmodule EventManager do
  # alias ExUnit.EventManager

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state), do: {:ok, state}

  def create_topic(topic) do
    GenServer.call(__MODULE__, {:create_topic, topic})
  end

  def enqueue_event(topic, event) do
    GenServer.call(__MODULE__, {:enqueue_event, topic, event})
  end

  def dequeue_event(topic) do
    GenServer.call(__MODULE__, {:dequeue_event, topic})
  end
end
