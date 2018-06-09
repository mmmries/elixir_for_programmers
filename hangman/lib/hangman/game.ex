defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters:    [],
    used:       MapSet.new()
  )

  def new do
    %Hangman.Game{
      letters: Dictionary.random_word |> String.codepoints,
    }
  end

  def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    { game, tally(game) }
  end
  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    { game, tally(game) }
  end

  def accept_move(game, _guess, _already_guessed=true) do
    %{game | game_state: :already_used}
  end
  def accept_move(game, guess, _already_guessed) do
    %{game | used: MapSet.put(game.used, guess)}
    |> score_guess(Enum.member?(game.letters, guess))
  end

  def score_guess(game, _letter_in_word = true) do
    if MapSet.subset?(MapSet.new(game.letters), game.used) do
      %{game | game_state: :won}
    else
      %{game | game_state: :good_guess}
    end
  end
  def score_guess(game, _letter_in_word = false) do
    if game.turns_left == 1 do
      %{game | turns_left: 0, game_state: :lost}
    else
      %{game | turns_left: game.turns_left - 1, game_state: :bad_guess}
    end
  end

  def tally(_game) do
    234
  end
end
