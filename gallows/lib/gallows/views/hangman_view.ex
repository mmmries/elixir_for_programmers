defmodule Gallows.HangmanView do
  use Gallows, :view

  defp word_so_far(%{letters: letters}) do
    letters |> Enum.join(" ")
  end
end
