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
      assert ^game = Game.make_move(game, "z")
    end
  end

  test "first time guessing a letter" do
    game = Game.new()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "guessing a letter twice returns :already used" do
    game = Game.new()
    game = Game.make_move(game, "x")
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "guessing all the letters in a word returns :won" do
    game = Game.new() |> Map.put(:letters, ["w", "o", "n"])
    assert game = Game.make_move(game, "w")
    assert %{turns_left: 7, game_state: :good_guess} = game
    assert game = Game.make_move(game, "o")
    assert %{turns_left: 7, game_state: :good_guess} = game
    assert game = Game.make_move(game, "n")
    assert %{turns_left: 7, game_state: :won} = game
  end

  test "guessing the wrong letters" do
    game = Game.new() |> Map.put(:letters, ["w", "o", "n"])
    moves = [
      {"a", :bad_guess, 6},
      {"b", :bad_guess, 5},
      {"c", :bad_guess, 4},
      {"d", :bad_guess, 3},
      {"e", :bad_guess, 2},
      {"f", :bad_guess, 1},
      {"g", :lost, 0},
    ]
    run_moves(moves, game)
  end

  test "bad and good guesses mixed" do
    game = Game.new() |> Map.put(:letters, ["m", "o", "o", "n"])
    moves = [
      {"a", :bad_guess, 6},
      {"b", :bad_guess, 5},
      {"m", :good_guess, 5},
      {"n", :good_guess, 5},
      {"c", :bad_guess, 4},
      {"o", :won, 4},
    ]
    run_moves(moves, game)
  end

  defp run_moves(moves, game) do
    Enum.reduce(moves, game, fn({guess, game_state, turns_left}, game) ->
      game = Game.make_move(game, guess)
      assert %{game_state: ^game_state, turns_left: ^turns_left} = game
      game
    end)
  end
end
