defmodule Bot do
  @letters for num <- ?a..?z, do: <<num>>
  @letter_frequency_map Enum.reduce(@letters, %{}, fn(letter, map) -> Map.put(map, letter, 0) end)

  def guess_letter(%{letters: letters, used: used}) do
    letter = letters
             |> length()
             |> words_of_size()
             |> letters_by_frequency()
             |> filter_by_used(used)
             |> pick_most_likely()
    IO.puts "\bBot: I'm guessing #{letter}"
    letter
  end

  defp words_of_size(size) do
    Dictionary.word_list()
    |> Enum.filter(fn(word) -> String.length(word) == size end)
  end

  defp letters_by_frequency(words) do
    Enum.reduce(words, @letter_frequency_map, fn(word, map) ->
      word |> String.codepoints |> Enum.reduce(map, fn(letter, map) ->
        Map.put(map, letter, map[letter] + 1)
      end)
    end)
  end

  defp filter_by_used(map, used) do
    Enum.reduce(used, map, fn(letter, map) ->
      Map.delete(map, letter)
    end)
  end

  defp pick_most_likely(letters_and_occurences) do
    letters_and_occurences
    |> Enum.sort(&( elem(&1, 1) >= elem(&2, 1) ))
    |> hd
    |> elem(0)
  end
end
