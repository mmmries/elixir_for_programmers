defmodule Gallows.HangmanController do
  use Gallows, :controller

  def index(conn, _params) do
    render conn, "index.html", product: "pear", quantity: 2
  end
end
