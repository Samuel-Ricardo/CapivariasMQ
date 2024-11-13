defmodule Capivariasmq do
  @moduledoc """
  Documentation for `Capivariasmq`.
  """
  alias Capivariasmq.EventManager
  alias Capivariasmq.Broker.LoadBalancer

  @doc """
  Hello world.

  ## Examples

      iex> Capivariasmq.hello()
      :world

  """
  def hello do
    :world
  end

  def main do
    # Start Application and Supervisor
    Application.ensure_all_started(:capivariasmq)

    EventManager.start_link(nil)

    EventManager.start_topic("payments")

    for n <- 1..50 do
      EventManager.enqueue_event("payments", "Payment #{n}")
    end

    # Inicia o LoadBalancer em paralelo com o Task.async
    Task.async(fn -> LoadBalancer.distribute_events("payments") end)

    for n <- 50..100 do
      EventManager.enqueue_event("payments", "Payment #{n}")
    end

    # Espera a execução da aplicação para não fechar imediatamente
    # Dorme por 1 segundo para garantir que o processo paralelo tenha tempo de executar
    Process.sleep(2000)

    #    System.halt(0)
  end
end

Capivariasmq.main()

