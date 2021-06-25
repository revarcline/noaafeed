defmodule Weatherlixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :weatherlixir,
      escript: escript_config(),
      name: "Weatherlixir",
      source_url: "https://github.com/revarcline/weatherlixir",
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:httpoison, "~> 1.0.0"},
      {:poison, "~> 3.1"}
    ]
  end

  defp escript_config do
    [
      main_module: Weatherlixir.CLI
    ]
  end
end
