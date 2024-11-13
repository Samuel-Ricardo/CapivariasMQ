defmodule Capivariasmq.Consumer do
  @moduledoc """
  Documentation for `Consumer`.
  """

  def process_event_err(event) do
    case :rand.uniform(10) do
      n when n <= 8 ->
        IO.inspect("Successfully processed: #{inspect(event)}")
        :ok

      _ ->
        IO.inspect("Error processing: #{inspect(event)}")
        :error
    end
  end

  def process_event(event) do
    IO.inspect("Processing event: #{inspect(event)}")
    :ok
  end
end
