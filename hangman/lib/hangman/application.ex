defmodule Hangman.Application do
  use Application

  def start(_type, _args) do
    DynamicSupervisor.start_link(name: Hangman.Supervisor, strategy: :one_for_one)
  end
end
