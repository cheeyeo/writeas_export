defmodule WriteasExportTest do
  use ExUnit.Case
  doctest WriteasExport.CLI
  doctest WriteasExport.JSONFetch

  test "the truth" do
    assert 1 + 1 == 2
  end
end
