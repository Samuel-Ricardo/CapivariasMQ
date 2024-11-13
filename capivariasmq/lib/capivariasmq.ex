defmodule Capivariasmq do
  @moduledoc """
  Documentation for `Capivariasmq`.
  """

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
    hello()
    IO.puts("Olá, mundo! Pedro")

    EventManager.start_link(nil)

    EventManager.create_topic("topic_1")
    #    EventManager.enqueue_event("topic_1", %{id: 1, content: "Evento 1"})
    #  EventManager.enqueue_event("topic_1", %{id: 2, content: "Evento 2"})

    for i <- 1..100 do
      EventManager.enqueue_event("topic_1", %{id: i, content: "Evento #{i}"})
    end

    LoadBalancer.distribute_events("topic_1")

    Process.sleep(1000)

    IO.puts("Olá, mundo!")
  end
end

Capivariasmq.main()
