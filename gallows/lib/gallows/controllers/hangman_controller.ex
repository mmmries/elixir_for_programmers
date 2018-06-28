defmodule Gallows.HangmanController do
  use Gallows, :controller

  def create_game(conn, _params) do
    {:ok, game} = Hangman.new_game()

    conn
    |> put_session(:game, game)
    |> render("game_field.html", tally: Hangman.tally(game))
  end

  def new_game(conn, _params) do
    render conn, "new_game.html"
  end
end
