defmodule GallowsWeb.HangmanControllerTest do
  use Gallows.ConnCase

  test "GET /hangman", %{conn: conn} do
    conn = get conn, "/hangman"
      assert html_response(conn, 200) =~ "Hangman"
  end
end
