defmodule Weatherlixir.CLI do
  @moduledoc """
  scrapes weather info from NOAA website based on location code
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
    OptionParser.parse(argv,
      switches: [help: :boolean, zip: :integer, city: :string],
      aliases: [h: :help, z: :zip, c: :city, s: :state]
    )
    |> elem(1)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation(args) do
    # String.match?(args, ~r/^\d{5}(?:[-\s]\d{4})?$/) -> by_zip(args)
  end

  def process(:help) do
    IO.puts("""
    usage: issues <city, state> or issues <zipcode>
    """)
  end

  def process({user, project, count}) do
    Weatherlixir.WeatherMap.fetch(user, project)
    |> decode_response()
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching weather: #{error["message"]}")
    System.halt(2)
  end
end
