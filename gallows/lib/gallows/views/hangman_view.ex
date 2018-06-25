defmodule Gallows.HangmanView do
  use Gallows, :view

 defp plural_of(1, noun), do: "1 #{noun}"
 defp plural_of(n, noun) when n > 1, do: "#{n} #{noun}s"
 defp plural_of(n, noun) when n < 1, do: {:safe, "<span style='color: red'>#{n} #{noun}s</span>"}
end
