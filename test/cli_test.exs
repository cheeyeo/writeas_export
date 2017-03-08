defmodule CliTest do
  use ExUnit.Case
  doctest WriteasExport

  import WriteasExport.CLI, only: [ parse_args: 1 ]

  test "help returned by option aprsing with -h and --help" do
    assert parse_args(["-h", "mycollection"]) == :help
    assert parse_args(["--help", "mycollection"]) == :help
  end

  test "return collection name" do
    assert parse_args(["mycollection"]) == {"mycollection"}
  end

  test "return path and a collection name" do
    assert parse_args(["mycollection", "--path", "lib"]) == {"mycollection", "lib"}
  end
end
