defmodule Capivariasmq.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  alias Capivariasmq.EventManager

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Capivariasmq.Worker.start_link(arg)
      # {Capivariasmq.Worker, arg}
      {Registry, keys: :unique, name: Registry.TopicRegistry},
      {EventManager, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Capivariasmq.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
