defmodule DictionaryTest do
  use ExUnit.Case

  test "getting a random word" do
    dict = Dictionary.start()
    word = Dictionary.random_word(dict)
    assert is_binary(word)
    assert byte_size(word) > 0
    assert byte_size(word) < 128
    assert String.contains?(word, " ") == false
  end
end
