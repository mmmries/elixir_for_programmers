defmodule Hangman.Game do
  defstruct turns_left: 7,
            game_state: :initializing,
            letters:    []

  def new do
    %Hangman.Game{
      letters: Dictionary.random_word |> String.codepoints,
    }
  end
end
