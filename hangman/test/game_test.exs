defmodule Hangman.GameTest do
  use ExUnit.Case, async: true
  alias Hangman.Game

  test "new returns a structure" do
    game = Game.new()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "generated words are always lower case" do
    game = Game.new()
    Enum.each(game.letters, fn(letter) ->
      assert letter =~ ~r/[a-z]/
    end)
  end
end
