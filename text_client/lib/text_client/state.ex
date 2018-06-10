defmodule TextClient.State do
  defstruct [:game, :guesser, :tally]

  def new(game, guesser) do
    %__MODULE__{
      game: game,
      tally: Hangman.tally(game),
      guesser: guesser,
    }
  end
end
