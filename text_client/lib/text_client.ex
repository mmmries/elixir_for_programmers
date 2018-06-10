defmodule TextClient do
  alias TextClient.Interact
  defdelegate start, to: Interact
  defdelegate start(guesser), to: Interact
end
