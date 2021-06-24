defmodule Weatherlixir.CLI do
  @moduledoc """
  calls OpenWeatherMap api based on city, city/state, or zip
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns help

  Otherwise, determines presence of Zip or City, State
  """
  def parse_args(argv) do
    OptionParser.parse!(argv,
      switches: [help: :boolean, zip: :string, city: :string],
      aliases: [h: :help, z: :zip, c: :city, s: :state]
    )
    |> elem(0)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation(zip: zip), do: check_zip(zip)
  def args_to_internal_representation(city: city), do: %{city: city}

  def args_to_internal_representation(city: city, state: state),
    do: %{city: city, state: state}

  def args_to_internal_representation(_), do: :help

  def check_zip(zip) do
    if String.match?(zip, ~r/^\d{5}(?:[-\s]\d{4})?$/) do
      %{zip: zip}
    else
      IO.puts("Must enter a valid 5 or 9 digit zip code")
      System.halt(2)
    end
  end

  def process(:help) do
    IO.puts("""
    usage: weatherlixir -c <city> ( -s <state> ) | -z <zipcode>
      if city is multiple words, please put in quotes, like "New York".
      --state or -s flag is optional with city
    """)
  end

  def process(opts) do
    # Weatherlixir.WeatherMap.fetch(user, project)
    # |> decode_response()
    IO.inspect(opts)
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching weather: #{error["message"]}")
    System.halt(2)
  end
end
