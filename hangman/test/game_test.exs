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

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new() |> Map.put(:game_state, state)
      assert { ^game, _ } = Game.make_move(game, "z")
    end
  end

  test "first time guessing a letter" do
    game = Game.new()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "guessing a letter twice returns :already used" do
    game = Game.new()
    {game, _tally} = Game.make_move(game, "x")
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "guessing all the letters in a word returns :won" do
    game = Game.new() |> Map.put(:letters, ["w", "o", "n"])
    assert {game, _tally} = Game.make_move(game, "w")
    assert %{turns_left: 7, game_state: :good_guess} = game
    assert {game, _tally} = Game.make_move(game, "o")
    assert %{turns_left: 7, game_state: :good_guess} = game
    assert {game, _tally} = Game.make_move(game, "n")
    assert %{turns_left: 7, game_state: :won} = game
  end

  test "guessing the wrong letters" do
    game = Game.new() |> Map.put(:letters, ["w", "o", "n"])
    assert {game, _tally} = Game.make_move(game, "a")
    assert %{turns_left: 6, game_state: :bad_guess} = game
    assert {game, _tally} = Game.make_move(game, "b")
    assert %{turns_left: 5, game_state: :bad_guess} = game
    assert {game, _tally} = Game.make_move(game, "c")
    assert %{turns_left: 4, game_state: :bad_guess} = game
    assert {game, _tally} = Game.make_move(game, "d")
    assert %{turns_left: 3, game_state: :bad_guess} = game
    assert {game, _tally} = Game.make_move(game, "e")
    assert %{turns_left: 2, game_state: :bad_guess} = game
    assert {game, _tally} = Game.make_move(game, "f")
    assert %{turns_left: 1, game_state: :bad_guess} = game
    assert {game, _tally} = Game.make_move(game, "g")
    assert %{turns_left: 0, game_state: :lost} = game
  end
end
