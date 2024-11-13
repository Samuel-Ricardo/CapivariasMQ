defmodule Capivariasmq.Broker do
  alias Capivariasmq.Consumer
  @retry_attempts 3

  def dispatch_event(event) do
    IO.puts("Dispatching event #{inspect(event)}")
    try_process(event, @retry_attempts)
  end

  defp try_process(event, attempts) when attempts > 0 do
    case Consumer.process_event(event) do
      :ok -> :ok
      :error -> try_process(event, attempts - 1)
    end
  end

  defp try_process(_event, 0), do: :failed
end
