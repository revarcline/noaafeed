defmodule Weatherlixir.OpenWeatherMap do
  @moduledoc "http get handling for OpenWeatherMap"
  @api_url Application.get_env(:weatherlixir, :api_url)
  @api_key "&appid=#{Application.get_env(:weatherlixir, :api_key)}"
  @units "&units=imperial"

  require Logger

  def fetch(opts) do
    Logger.info("Fetching weather data for #{stringify_keys(opts)}: #{stringify_values(opts)}")

    issues_url(opts)
    |> HTTPoison.get()
    |> handle_response
  end

  def issues_url(%{city: city, state: state}) do
    "#{@api_url}q=#{city},#{state}#{@api_key}#{@units}"
  end

  def issues_url(%{city: city}), do: "#{@api_url}q=#{city}#{@api_key}#{@units}"
  def issues_url(%{zip: zip}), do: "#{@api_url}zip=#{zip}#{@api_key}#{@units}"

  def handle_response({_, %{status_code: status_code, body: body}}) do
    Logger.info("Got response: status code=#{status_code}")
    Logger.debug(fn -> inspect(body) end)
    {status_code |> check_for_error(), body |> Poison.Parser.parse!()}
  end

  def check_for_error(200), do: :ok
  def check_for_error(_), do: :error

  def stringify_keys(opts) do
    opts
    |> Map.keys()
    |> Enum.map(&Atom.to_string(&1))
    |> Enum.join(", ")
  end

  def stringify_values(opts) do
    opts
    |> Map.values()
    |> Enum.join(", ")
  end
end
