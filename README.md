# Weatherlixir

elixir cli weather app

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `noaafeed` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:weatherlixir, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/noaafeed](https://hexdocs.pm/noaafeed).

## Adding API key

This relies on the free OpenWeatherMap API, you can get your own free key [here](https://home.openweathermap.org/users/sign_up) and use the `config/dev.secret.exs` file
