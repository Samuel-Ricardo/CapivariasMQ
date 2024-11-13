defmodule Broker do
  def dispatch_event(topic) do
    events = EventManager.dequeue_event(topic)

    Task.async_stream(events, fn event -> Consumer.process_event(event) end)
    |> Enum.to_list()
  end
end
