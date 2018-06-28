defmodule Gallows.HangmanView do
  use Gallows, :view

  def render("game.html", %{tally: tally}=assigns) do
    case tally.game_state do
      :won -> render("game_won.html", assigns)
      :lost -> render("game_lost.html", assigns)
      _ -> render("game_field.html", assigns)
    end
  end
  

  defp word_so_far(%{letters: letters}) do
    letters |> Enum.join(" ")
  end

  defp prompt(%{game_state: :invalid_guess}), do: "Please guess a single lower-case letter"
  defp prompt(%{game_state: :good_guess}), do: "Yup, you are getting closer"
  defp prompt(%{game_state: :bad_guess}), do: "Nope, that letter's not in the word"
  defp prompt(%{game_state: :initializing}), do: "Take a guess"
  defp prompt(%{game_state: :already_used}), do: "You already guessed that letter"
end
