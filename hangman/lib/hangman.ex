defmodule Hangman do
  alias Hangman.Game

  defdelegate new_game, to: Game, as: :new
  defdelegate tally(game), to: Game

  def make_move(game, letter) do
    game = Game.make_move(game, letter)
    { game, tally(game) }
  end
end
