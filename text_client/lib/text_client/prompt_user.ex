defmodule TextClient.PromptUser do
  def guess_letter(_tally), do: guess_letter()

  def guess_letter() do
    IO.gets("Guess a letter: ")
    |> String.trim
    |> validate_input
  end

  def validate_input(:eof) do
    IO.puts "Looks like you are giving up?"
    exit(:normal)
  end
  def validate_input({:error, reason}) do
    IO.puts "Error #{reason}"
    exit(:normal)
  end
  def validate_input(str) do
    if str =~ ~r/\A[a-z]\z/ do
       str
    else
      IO.puts "Woops, please enter a single lower-case letter for your guess"
      guess_letter()
    end
  end
end
