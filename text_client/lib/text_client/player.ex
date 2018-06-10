defmodule TextClient.Player do
  alias TextClient.State

  def play(%State{tally: %{game_state: :won}}) do
    IO.puts "You Win!!! 👍😎"
  end
  def play(%State{tally: %{game_state: :lost}}) do
    IO.puts "You Lost!! 😅😭"
  end

  def play(state) do
    respond(state.tally)
    show_state(state.tally)
    state = accept_guess(state)
    IO.puts "\n"
    play(state)
  end

  defp accept_guess(state = %{game_service: game}) do
    letter = IO.gets("Guess a letter: ") |> String.trim
    { game, tally} = Hangman.make_move(game, letter)
    %State{state | game_service: game, tally: tally}
  end

  defp respond(%{game_state: :initializing}), do: IO.puts "Let's get started"
  defp respond(%{game_state: :good_guess}), do: IO.puts "Nice Work, that is in the word"
  defp respond(%{game_state: :bad_guess}), do: IO.puts "Nope, that's not in the word"
  defp respond(%{game_state: :already_used}), do: IO.puts "You've already guessed that letter"

  defp show_state(%{letters: letters, turns_left: left, used: used}) do
    IO.puts "Letters: #{Enum.join(letters, " ")}"
    IO.puts "Turns Left: #{left}"
    IO.puts ""
    IO.puts "Guessed So Far: #{Enum.join(used, " ")}"
  end
end
