defmodule Capivariasmq.EventManager.TopicQueue do
  use GenServer

  def start_link(topic) do
    GenServer.start_link(__MODULE__, [], name: via_tuple(topic))
  end

  def init(state), do: {:ok, state}

  def handle_cast({:enqueue, event}, state) do
    {:noreply, state ++ [event]}
  end

  def handle_call(:dequeue, _from, [event | rest]) do
    {:reply, {:ok, event}, rest}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, :empty, []}

  defp via_tuple(topic), do: {:via, Registry, {Registry.TopicRegistry, topic}}
end
