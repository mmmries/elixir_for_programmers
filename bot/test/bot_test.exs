defmodule BotTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "bot guesses a letter when given a tally" do
    capture_io(fn ->
      tally = %{letters: ["_", "_", "_", "_"], used: ["a","e"]}
      for _i <- 1..1000 do
        letter = Bot.guess_letter(tally)
        assert letter =~ ~r/\A[a-z]\z/
      end
    end)
  end
end
