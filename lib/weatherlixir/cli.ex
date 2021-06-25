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

  def args_to_internal_representation(city: city, state: state) do
    check_state(%{city: city, state: state})
  end

  def args_to_internal_representation(_), do: :help

  def check_zip(zip) do
    if String.match?(zip, ~r/^\d{5}(?:[-\s]\d{4})?$/) do
      %{zip: zip}
    else
      IO.puts("Must enter a valid 5 or 9 digit zip code")
      System.halt(2)
    end
  end

  def check_state(city_state) do
    if String.match?(
         city_state.state,
         ~r/ ^(?-i:A[LKSZRAEP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])$ /
       ) do
      city_state
    else
      IO.puts("Must enter a valid two letter state code")
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
    Weatherlixir.OpenWeatherMap.fetch(opts)
    |> print_output()

    # |> decode_response()
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching weather: #{error["message"]}")
    System.halt(2)
  end

  def print_output(%{
        "main" => %{
          "feels_like" => feels_like,
          "humidity" => humidity,
          "temp" => temp,
          "temp_max" => temp_max,
          "temp_min" => temp_min
        },
        "name" => name,
        "weather" => %{
          "description" => description
        }
      }) do
    """
    #{temp}°F and #{description} in #{name}, feels like #{feels_like}°F.
    High of #{temp_max}°F and low of #{temp_min}°F with a humidity of #{humidity}%.
    """
  end
end
