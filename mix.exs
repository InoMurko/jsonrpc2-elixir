defmodule JSONRPC2.Mixfile do
  use Mix.Project

  @version "1.1.1"

  def project do
    [
      app: :jsonrpc2,
      version: @version,
      elixir: "~> 1.3",
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      description: description(),
      package: package(),
      name: "JSONRPC2",
      docs: [
        source_ref: "v#{@version}",
        main: "readme",
        canonical: "http://hexdocs.pm/jsonrpc2",
        source_url: "https://github.com/fanduel/jsonrpc2-elixir",
        extras: ["README.md"]
      ],
      dialyzer: [plt_add_apps: [:shackle, :ranch, :plug, :hackney]],
      xref: [
        exclude: [
          :hackney,
          :ranch,
          :shackle,
          :shackle_pool,
          Plug.Conn,
          Plug.Adapters.Cowboy,
          Plug.Adapters.Cowboy2
        ]
      ]
    ]
  end

  def application do
    [applications: [:logger], env: [serializer: Jason]]
  end

  defp deps do
    [
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev, :test], runtime: false},
      {:ethereumex, "~> 0.5.1"},
      {:jason, "~> 1.1"},
      {:ranch, "~> 1.6"},
      {:shackle, "~> 0.5"},
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},
      {:hackney, "~> 1.6"},
      {:cowboy, "~> 2.5"},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp description do
    "JSON-RPC 2.0 for Elixir."
  end

  defp package do
    [
      maintainers: ["Eric Entin"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/fanduel/jsonrpc2-elixir"},
      files: ~w(mix.exs README.md LICENSE lib)
    ]
  end
end
