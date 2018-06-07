defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "greets the world" do
    assert is_binary(Hangman.hello())
  end
end
