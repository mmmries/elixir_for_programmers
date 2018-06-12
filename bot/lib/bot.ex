defmodule Bot do
  @letters for num <- ?a..?z, do: <<num>>
  @letter_frequency_map Enum.reduce(@letters, %{}, fn(letter, map) -> Map.put(map, letter, 0) end)

  def guess_letter(%{letters: letters, used: used}) do
    letter = letters
             |> build_regex()
             |> filter_words()
             |> letters_by_frequency()
             |> filter_by_used(used)
             |> pick_most_likely()
    IO.puts "\bBot: I'm guessing #{letter}"
    letter
  end

  defp build_regex(letters) do
    body = letters
           |> Enum.map(&letter_to_pattern_chunk/1)
           |> Enum.join
    Regex.compile!("\\A#{body}\\z")
  end

  defp letter_to_pattern_chunk("_"), do: "[a-z]"
  defp letter_to_pattern_chunk(letter), do: letter

  defp filter_words(regex) do
    Dictionary.filtered_word_list(fn(word) -> word =~ regex end)
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
