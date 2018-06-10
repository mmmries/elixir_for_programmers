defmodule TextClient.State do
  defstruct [:game_service, :tally, :guessed]

  def new(game) do
    %__MODULE__{
      game_service: game,
      tally: Hangman.tally(game),
    }
  end
end
