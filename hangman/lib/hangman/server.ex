defmodule Hangman.Server do
  use GenServer
  alias Hangman.Game

  def start_link(nil) do
    GenServer.start_link(__MODULE__, nil)
  end

  def make_move(pid, letter) do
    GenServer.call(pid, {:make_move, letter})
  end

  def init(_) do
    {:ok, Game.new()}
  end

  def handle_call({:make_move, letter}, _from, game) do
    {game, tally} = Game.make_move(game, letter)
    {:reply, tally, game}
  end

  def handle_call(:tally, _from, game) do
    {:reply, Game.tally(game), game}
  end
end
