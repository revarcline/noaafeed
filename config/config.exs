use Mix.Config

config :weatherlixir,
  api_url: "api.openweathermap.org/data/2.5/weather?",
  api_key: "hidden"

config :logger, compile_time_purge_matching: [[level_lower_than: :info]]
