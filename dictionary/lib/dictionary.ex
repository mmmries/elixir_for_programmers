defmodule Dictionary do
  @words "assets/words.txt" |> File.read! |> String.split("\n", trim: true)

  def random_word do
    Enum.random(@words)
  end
end
