defmodule CliTest do
  use ExUnit.Case
  doctest Weatherlixir

  import Weatherlixir.CLI, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options, also just state" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
    assert parse_args(["garbage"]) == :help
    assert parse_args(["-s", "garbage"]) == :help
  end

  test "city and state parse to correct map" do
    assert parse_args(["-c", "New Orleans", "-s", "LA"]) == %{city: "New Orleans", state: "LA"}

    assert parse_args(["--city", "New Orleans", "--state", "LA"]) == %{
             city: "New Orleans",
             state: "LA"
           }
  end

  test "city alone parses to correct map" do
    assert parse_args(["-c", "New Orleans"]) == %{city: "New Orleans"}
    assert parse_args(["--city", "New Orleans"]) == %{city: "New Orleans"}
  end

  test "valid zip code parses to correct map" do
    assert parse_args(["-z", "70116"]) == %{zip: "70116"}
    assert parse_args(["--zip", "70116"]) == %{zip: "70116"}
    assert parse_args(["-z", "70116-1121"]) == %{zip: "70116-1121"}
  end

  defp fake_created_at_list(values) do
    for value <- values,
        do: %{"created_at" => value, "other_data" => "xxx"}
  end
end
