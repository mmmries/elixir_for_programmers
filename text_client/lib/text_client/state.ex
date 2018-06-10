defmodule TextClient.State do
  defstruct [:game_service, :tally]

  def new(game) do
    %__MODULE__{
      game_service: game,
      tally: Hangman.tally(game),
    }
  end
end
