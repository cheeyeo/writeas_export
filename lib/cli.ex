defmodule WriteasExport do

  @user_agent [ {"User-agent", "Elixir-Writeas_Export"} ]

  def main(args) do
    parse_args(args)
    |> process
  end

  @doc """
  Parse the arguments provided on the command line.

  ## Example

    iex> WriteasExport.parse_args(["beardyjay"])
    {"beardyjay"}

    iex> WriteasExport.parse_args(["--help"])
    :help
  """
  def parse_args(args) do
    parse = OptionParser.parse(args, switches: [help: :boolean], aliases: [h: :help])
    case parse do
      {[help: true], _, _}
        -> :help
      {_, [collection_name], _}
        -> {collection_name}
    end
  end

  def process({name}) do
    fetch(name)

    IO.puts "Completed"
  end

  @doc """
  Display help message

  ## Example

    iex> WriteasExport.process(:help)
    :ok

  """
  def process(:help) do
    IO.puts """
    Write.as Export
    - - - - -
    usage: writeas_export <collection_name>
    example: writeas_export beardyjay
    """
  end

  def fetch(collection_name) do
    url(collection_name)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  @doc """
    Returns the URL with the added string interpolation.

  ## Examples
  
    iex> WriteasExport.url("beardyjay")
    "https://write.as/api/collections/beardyjay/posts"

  """
  def url(collection_name) do
    "https://write.as/api/collections/#{collection_name}/posts"
  end

  def handle_response({:ok, %HTTPoison.Response{body: body}}) do
    {:ok, Poison.decode!(body)}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

end
