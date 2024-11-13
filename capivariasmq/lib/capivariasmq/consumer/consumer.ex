defmodule Consumer do
  @moduledoc """
  Documentation for `Consumer`.
  """

  def process_event(event) do
    IO.inspect("processing event: #{inspect(event)}")
  end
end
