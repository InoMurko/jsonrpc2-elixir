defmodule JSONRPC2.Mixfile do
  use Mix.Project

  @version "1.1.1"

  def project do
    [
      app: :jsonrpc2,
      version: @version,
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
      elixirc_options: [warnings_as_errors: true],
      elixir: "~> 1.7.3",
      start_permanent: Mix.env() == :prod,
      dialyzer: [
        flags: [:underspecs, :unknown, :unmatched_returns],
        plt_add_apps: [:mix, :iex, :ex_unit, :shackle, :ranch, :plug, :hackney, :jason, :websockex, :cowboy]
      ]
    ]
  end

  def application do
    [applications: [:logger], env: [serializer: Jason]]
  end

  defp deps do
    [
      {:cowboy, "~> 2.5"},
      {:jason, "~> 1.1"},
      {:ranch, "~> 1.6"},
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},
      # testing and other stuff
      {:credo, "~> 1.0.0-rc1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev, :test], runtime: false},
      {:hackney, "~> 1.6", only: [:test]},
      {:websockex, git: "https://github.com/InoMurko/websockex.git", branch: "master", only: [:test]},
      {:shackle, git: "https://github.com/lpgauth/shackle.git", tag: "0.6.2", only: [:test]},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
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
