defmodule Dictionary.WordList do
  defstruct words: []

  def start() do
    words = "../../assets/words.txt"
            |> Path.expand(__DIR__)
            |> File.read!
            |> String.split("\n", trim: true)
    %__MODULE__{words: words}
  end

  def random_word(%__MODULE__{words: words}) do
    Enum.random(words)
  end

  def word_list(%__MODULE__{words: words}) do
    words
  end
end
