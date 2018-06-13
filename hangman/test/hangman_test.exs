defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "can create a new game" do
    assert {:ok, game_pid} = Hangman.new_game()
    assert %{game_state: :initializing} = Hangman.tally(game_pid)
  end
end
