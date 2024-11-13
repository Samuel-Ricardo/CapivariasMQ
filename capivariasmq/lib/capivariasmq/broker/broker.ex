defmodule Broker do
  def dispatch_event(events) do
    # events = EventManager.dequeue_event(topic)

    Task.async_stream(events, fn event -> Consumer.process_event(event) end)
    |> Enum.to_list()
  end
end
