defmodule DictionaryTest do
  use ExUnit.Case

  test "getting a random word" do
    word = Dictionary.random_word()
    assert is_binary(word)
    assert byte_size(word) > 0
    assert byte_size(word) < 128
    assert String.contains?(word, " ") == false
  end
end
