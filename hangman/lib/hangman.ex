defmodule Hangman do
  alias Hangman.Server

  def new_game() do
     Server.start_link()
  end

  def make_move(game_pid, letter) do
    GenServer.call(game_pid, {:make_move, letter})
  end

  def tally(game_pid) do
    GenServer.call(game_pid, :tally)
  end
end
