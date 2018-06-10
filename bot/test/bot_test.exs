defmodule BotTest do
  use ExUnit.Case

  test "bot guesses a letter when given a tally" do
    tally = %{letters: ["_", "_", "_", "_"]}
    for _i <- 1..100 do
      letter = Bot.guess_letter(tally)
      assert letter =~ ~r/\A[a-z]\z/
    end
  end
end
