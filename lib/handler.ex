defmodule JSONRPC2.SpecHandler do
  use JSONRPC2.Server.Handler

  def handle_request("subtract", [x, y]) do
    x - y
  end

  def handle_request("subtract", %{"minuend" => x, "subtrahend" => y}) do
    x - y
  end

  def handle_request("update", _) do
    :ok
  end

  def handle_request("sum", numbers) do
    Enum.sum(numbers)
  end

  def handle_request("get_data", []) do
    ["hello", 5]
  end
end
