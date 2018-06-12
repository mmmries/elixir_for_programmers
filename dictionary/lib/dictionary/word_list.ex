defmodule Dictionary.WordList do
  defstruct words: []

  def start_link do
    Agent.start_link(&start/0, name: __MODULE__)
  end

  def start() do
    words = "../../assets/words.txt"
            |> Path.expand(__DIR__)
            |> File.read!
            |> String.split("\n", trim: true)
    %__MODULE__{words: words}
  end

  def filtered_word_list(fun) do
    Agent.get(__MODULE__, fn(%__MODULE__{words: words}) ->
      Enum.filter(words, fun)
    end)
  end

  def random_word() do
    Agent.get(__MODULE__, fn(%__MODULE__{words: words}) -> Enum.random(words) end)
  end

  def word_list() do
    Agent.get(__MODULE__, fn(%__MODULE__{words: words}) -> words end)
  end
end
