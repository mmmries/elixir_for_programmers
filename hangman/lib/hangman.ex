defmodule Hangman do
  def new_game() do
    DynamicSupervisor.start_child(Hangman.Supervisor, {Hangman.Server, nil})
  end

  def make_move(game_pid, letter) do
    GenServer.call(game_pid, {:make_move, letter})
  end

  def tally(game_pid) do
    GenServer.call(game_pid, :tally)
  end
end
