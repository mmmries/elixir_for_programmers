defmodule Dictionary.Application do
  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      {Dictionary.WordList, [name: Dictionary.WordList]},
    ]
    options = [strategy: :one_for_one]
    Supervisor.start_link(children, options)
  end
end
