defmodule Gallows.HangmanView do
  use Gallows, :view
  
  defp alert(class, message) do
    content_tag(:div, message, class: "alert alert-#{class}")
  end

  defp game_over?(%{game_state: :lost}), do: true
  defp game_over?(%{game_state: :won}),  do: true
  defp game_over?(_tally),               do: false

  defp word_so_far(%{letters: letters}) do
    letters |> Enum.join(" ")
  end

  defp prompt(%{game_state: game_state}), do: prompt(game_state)
  defp prompt(:won),           do: alert("success", "You Win 🎯🎆🎉")
  defp prompt(:lost),          do: alert("warning", "You Lost 😭")
  defp prompt(:invalid_guess), do: alert("danger", "Please guess a single lower-case letter")
  defp prompt(:good_guess),    do: alert("success", "Yup, you are getting closer")
  defp prompt(:bad_guess),     do: alert("warning", "Nope, that letter's not in the word")
  defp prompt(:initializing),  do: alert("info", "Take a guess")
  defp prompt(:already_used),  do: alert("warning", "You already guessed that letter")
end
