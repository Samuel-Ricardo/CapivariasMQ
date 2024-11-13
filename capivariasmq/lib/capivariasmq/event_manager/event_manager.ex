defmodule Capivariasmq.EventManager do
  alias Capivariasmq.EventManager.TopicQueue
  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok), do: DynamicSupervisor.init(strategy: :one_for_one)

  def start_topic(topic) do
    spec = {TopicQueue, topic}
    {:ok, pid} = DynamicSupervisor.start_child(__MODULE__, spec)
    Registry.register(Registry.TopicRegistry, topic, pid)
  end

  def enqueue_event(topic, event) do
    case Registry.lookup(Registry.TopicRegistry, topic) do
      [{pid, _}] -> GenServer.cast(pid, {:enqueue, event})
      [] -> {:error, :topic_not_found}
    end
  end

  def dequeue_event(topic) do
    GenServer.call(__MODULE__, {:dequeue_event, topic})
  end
end
