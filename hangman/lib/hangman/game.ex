defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters:    [],
    used:       MapSet.new()
  )

  def new do
    %Hangman.Game{
      letters: Dictionary.random_word() |> String.codepoints,
    }
  end

  def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    game
  end
  def make_move(game, guess) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      used: Enum.into(game.used, []),
    }
  end

  ########## PRIVATE ############

  defp accept_move(game, _guess, _already_guessed=true) do
    %{game | game_state: :already_used}
  end
  defp accept_move(game, guess, _already_guessed) do
    %{game | used: MapSet.put(game.used, guess)}
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _letter_in_word = true) do
    if MapSet.subset?(MapSet.new(game.letters), game.used) do
      %{game | game_state: :won}
    else
      %{game | game_state: :good_guess}
    end
  end
  defp score_guess(game = %{turns_left: 1}, _letter_in_word = false) do
    %{game | turns_left: 0, game_state: :lost}
  end
  defp score_guess(game, _letter_in_word = false) do
    %{game | turns_left: game.turns_left - 1, game_state: :bad_guess}
  end

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn(letter) -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _in_word = true),   do: letter
  defp reveal_letter(_letter, _in_word = false), do: "_"
end
