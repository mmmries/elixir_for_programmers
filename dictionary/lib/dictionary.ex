defmodule Dictionary do
  alias Dictionary.WordList

  defdelegate start(), to: WordList
  defdelegate random_word(), to: WordList
  defdelegate word_list(), to: WordList
  defdelegate filtered_word_list(fun), to: WordList
end
