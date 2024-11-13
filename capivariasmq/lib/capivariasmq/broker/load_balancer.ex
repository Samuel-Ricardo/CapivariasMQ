defmodule LoadBalancer do
  def distribute_events(topic) do
    events = EventManager.dequeue_event(topic)

    Task.async_stream(events, &Broker.dispatch_event(&1),
      max_concurrency: System.schedulers_online()
    )
    |> Enum.to_list()
  end
end
