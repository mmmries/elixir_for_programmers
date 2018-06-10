defmodule TextClient.Interact do
  alias TextClient.{Player,State}

  def start do
    Hangman.new_game()
    |> State.new()
    |> Player.play()
  end
end
