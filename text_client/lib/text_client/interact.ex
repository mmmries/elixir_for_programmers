defmodule TextClient.Interact do
  alias TextClient.{Player,State}

  def start, do: start(TextClient.PromptUser)

  def start(guesser) do
    {:ok, game} = Hangman.new_game()
    game
    |> State.new(guesser)
    |> play()
  end

  def play(%State{tally: %{game_state: :won}}) do
    IO.puts "You Win!!! 👍😎"
  end
  def play(%State{tally: %{game_state: :lost}}) do
    IO.puts "You Lost!! 😅😭"
  end
  def play(state) do
    show_state(state.tally)
    guess = apply(state.guesser, :guess_letter, [state.tally])
    tally = Hangman.make_move(state.game, guess)
    IO.puts ""
    play(%{ state | game: state.game, tally: tally })
  end

  defp respond(%{game_state: :initializing}), do: IO.puts "Let's get started"
  defp respond(%{game_state: :good_guess}), do: IO.puts "Nice Work, that is in the word"
  defp respond(%{game_state: :bad_guess}), do: IO.puts "Nope, that's not in the word"
  defp respond(%{game_state: :already_used}), do: IO.puts "You've already guessed that letter"

  defp show_state(tally=%{letters: letters, turns_left: left, used: used}) do
    respond(tally)
    IO.puts "Letters: #{Enum.join(letters, " ")}"
    IO.puts "Guessed So Far: #{Enum.join(used, " ")} (#{left} misses left)"
  end
end
