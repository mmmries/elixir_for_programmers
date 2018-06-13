defmodule Hangman do
  alias Hangman.Game

  defdelegate new_game, to: Game, as: :new
  defdelegate make_move(game, letter), to: Game
  defdelegate tally(game), to: Game
end
