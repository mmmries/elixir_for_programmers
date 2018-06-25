defmodule Gallows.HangmanController do
  use Gallows, :controller

  def new_game(conn, _params) do
    render conn, "new_game.html", product: "pear", quantity: 2
  end
end
