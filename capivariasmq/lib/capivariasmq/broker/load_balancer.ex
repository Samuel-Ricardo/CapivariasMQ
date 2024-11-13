defmodule Capivariasmq.Broker.LoadBalancer do
  def distribute_events(topic) do
    distribute_loop(topic)
  end

  defp distribute_loop(topic) do
    case Registry.lookup(Registry.TopicRegistry, topic) do
      [{pid, _}] ->
        events = GenServer.call(pid, :dequeue)

        # IO.puts("Events available: #{inspect(events)}")

        case events do
          {:ok, event} ->
            event_list = [event]

            IO.pinspect("Load balancer processing event: #{inspect(event)}")

            Task.async_stream(
              event_list,
              fn event ->
                Capivariasmq.Broker.dispatch_event(event)
              end,
              max_concurrency: System.schedulers_online()
            )
            |> Enum.to_list()

          _ ->
            nil

            # IO.puts("No events available, waiting for new events...")
        end

        distribute_loop(topic)

      [] ->
        IO.puts("Error: Topic #{inspect(topic)} not found")
        {:error, :topic_not_found}
    end
  end
end
