defmodule Capivariasmq.Config do
  @retry_attempts Application.get_env(:event_system, :retry_attempts, 3)
  @max_concurrency Application.get_env(
                     :event_system,
                     :max_concurrency,
                     System.schedulers_online()
                   )

  def retry_attempts, do: @retry_attempts
  def max_concurrency, do: @max_concurrency
end
