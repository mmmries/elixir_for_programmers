defmodule Bot do
  @letters for num <- ?a..?z, do: <<num>>

  def guess_letter(_tally) do
    Enum.random(@letters)
  end
end
