[![Build Status](https://travis-ci.org/fanduel/jsonrpc2-elixir.svg?branch=master)](https://travis-ci.org/fanduel/jsonrpc2-elixir)

# JSONRPC2

JSON-RPC 2.0 for Elixir.

Use the included line-based TCP/TLS server/client, JSON-in-the-body HTTP(S) server/client, or bring your own transport.

See the [`examples`](https://github.com/fanduel/jsonrpc2-elixir/tree/master/examples) directory as well as the [`JSONRPC2`](https://hexdocs.pm/jsonrpc2/JSONRPC2.html) docs for examples.

## Installation

1. Add `jsonrpc2` and `poison` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:jsonrpc2, "~> 1.0"}, {:poison, "~> 3.1"}]
end
```

2. Ensure `jsonrpc2` and`poison` are started before your application:

```elixir
def application do
  [applications: [:jsonrpc2]]
end
```

## Serialization

Uses `Jason` by default.

## TCP/TLS server

If you plan to use the TCP/TLS server, you also need to add `ranch` to your deps/apps.

```elixir
def deps do
  [..., {:ranch, "~> 1.3"}]
end
```

```elixir
def application do
  [applications: [..., :ranch]]
end
```

## TCP/TLS client

If you plan to use the TCP/TLS client, you also need to add `shackle` to your deps/apps.

```elixir
def deps do
  [..., {:shackle, "~> 0.5"}]
end
```

```elixir
def application do
  [applications: [..., :shackle]]
end
```

## HTTP(S) server

If you plan to use the HTTP(S) server, you also need to add `plug` and `cowboy` to your deps/apps.

For Cowboy 1.x
```elixir
def deps do
  [..., {:plug, "~> 1.3"}, {:cowboy, "~> 1.1"}]
end
```

For Cowboy 2.x
```elixir
def deps do
  [..., {:plug, "~> 1.3"}, {:cowboy, "~> 2.4"}]
end
```

```elixir
def application do
  [applications: [..., :plug, :cowboy]]
end
```

## HTTP(S) client

If you plan to use the HTTP(S) client, you also need to add `hackney` to your deps/apps.

```elixir
def deps do
  [..., {:hackney, "~> 1.7"}]
end
```

```elixir
def application do
  [applications: [..., :hackney]]
end
```
