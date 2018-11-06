defmodule JSONRPC2.Serializers.Jason do
  @moduledoc false

  def decode(json) do
    try do
      {:ok, Jason.decode!(json)}
    catch
      kind, payload -> {:error, {kind, payload}}
    end
  end

  def encode(json) do
    try do
      {:ok, Jason.encode!(json)}
    catch
      kind, payload -> {:error, {kind, payload}}
    end
  end
end
