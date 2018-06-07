defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "can create a new game" do
    assert Hangman.new_game().__struct__ == Hangman.Game
  end
end
