defmodule NoaaFeed.CLI do
  @moduledoc """
  scrapes weather info from NOAA website based on location code
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end
end
