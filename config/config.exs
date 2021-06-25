use Mix.Config

config :weatherlixir,
  api_url: "api.openweathermap.org/data/2.5/weather?",
  api_key: System.get_env("OPENWEATHER_API_KEY")

config :logger, compile_time_purge_matching: [[level_lower_than: :info]]
