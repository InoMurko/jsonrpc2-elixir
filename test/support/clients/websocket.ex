defmodule JSONRPC2.Clients.WebSocket do
  @moduledoc """
  A client for JSON-RPC 2.0 using an WebSocket transport with JSON in the body.
  """

  use WebSockex
  require Logger

  #@spec call(String.t(), JSONRPC2.method(), JSONRPC2.params()) :: :ok

  # def call(
  #       url,
  #       method,
  #       params
  #     ) do
  #   {:ok, pid} = __MODULE__.start_link(url)
  #   serializer = Jason
  #   {:ok, payload} = JSONRPC2.Request.serialized_request({method, params, 0}, serializer)
  #   :ok = __MODULE__.call(pid, payload)

  #   {:ok, 1}
  # end

  def handle_request({:call, method, params, string_id}, state) do
    external_request_id_int = external_request_id(state.request_counter)

    external_request_id =
      if string_id do
        Integer.to_string(external_request_id_int)
      else
        external_request_id_int
      end

    {:ok, data} =
      {method, params, external_request_id}
      |> JSONRPC2.Request.serialized_request(Jason)

    new_state = %{state | request_counter: external_request_id_int + 1}
    {:ok, external_request_id, [data, "\r\n"], new_state}
  end

  def handle_request({:notify, method, params}, state) do
    {:ok, data} = JSONRPC2.Request.serialized_request({method, params}, Jason)

    {:ok, nil, [data, "\r\n"], state}
  end

  def start_link(url) do
    WebSockex.start_link(url, __MODULE__, %{request_counter: 0}, [])
  end

  @spec call(pid, String.t()) :: :ok
  def call(client, message) do
    Logger.info("Sending message: #{message}")
    WebSockex.send_frame(client, {:text, message})
  end

  def handle_connect(_conn, state) do
    Logger.info("Connected!")
    {:ok, state}
  end

  def handle_frame({:text, msg}, %{request_counter: _}) do
    Logger.info("Received Message: #{msg}")
    {:ok, :fake_state}
  end

  def handle_disconnect(%{reason: {:local, reason}}, state) do
    Logger.info("Local close with reason: #{inspect(reason)}")
    {:ok, state}
  end

  def handle_disconnect(disconnect_map, state) do
    super(disconnect_map, state)
  end
end
