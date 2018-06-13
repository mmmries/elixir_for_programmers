defmodule Dictionary.WordList do
  use Agent

  def start_link(options) do
    Agent.start_link(&start/0, options)
  end

  def start() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!
    |> String.split("\n", trim: true)
  end

  def filtered_word_list(fun) do
    Agent.get(__MODULE__, fn(words) ->
      Enum.filter(words, fun)
    end)
  end

  def random_word() do
    Agent.get(__MODULE__, fn(words) -> Enum.random(words) end)
  end

  def word_list() do
    Agent.get(__MODULE__, fn(words) -> words end)
  end
end
