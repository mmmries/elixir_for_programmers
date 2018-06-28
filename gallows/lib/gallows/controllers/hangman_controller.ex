defmodule Gallows.HangmanController do
  use Gallows, :controller

  def create_game(conn, _params) do
    {:ok, game} = Hangman.new_game()

    conn
    |> put_session(:game, game)
    |> render(:game, tally: Hangman.tally(game))
  end

  def make_move(conn, %{"make_move" => %{"guess" => letter}}) do
    tally = attempt_move(conn, letter)

    put_in(conn.params["make_move"]["guess"], "")
    |> render(:game, tally: tally)
  end

  def new_game(conn, _params) do
    render conn, "new_game.html"
  end

  defp attempt_move(conn, guess) do
    game = get_session(conn, :game)
    if valid_move?(guess) do
      Hangman.make_move(game, guess)
    else
      Hangman.tally(game) |> Map.put(:game_state, :invalid_guess)
    end
  end
  defp valid_move?(letter), do: letter =~ ~r/\A[a-z]\z/
end
