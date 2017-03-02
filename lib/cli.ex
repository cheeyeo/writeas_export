defmodule WriteasExport do
  @user_agent [ {"User-agent", "Elixir-Writeas_Export"} ]

  alias WriteasExport.Collection
  alias WriteasExport.Data
  alias WriteasExport.Post

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
    |> HTTPoison.get(@user_agent, [ ssl: [{:versions, [:'tlsv1.2']}] ])
    |> handle_response
    |> decode_posts
    |> display_posts
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

  @doc """
    Takes the response body and parses it. The response is in JSON.

    Here, we are using Poision.decode! as we are transforming the
    response body into structs. We can also leave out the transformation
    and use plain Poison.Parser.parse!(body) instead which will give us
    a map to access from.

    I guess IMHO, I feel that this is why most people use Poison which is to serialize / deserialze the responses using custom structs rather than just parsing responses alone but this can be tweaked.
  """

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    posts = Poison.decode!(body,
      as: %Collection{data: %Data{posts: [%Post{}]}}
    )

    {:ok, posts}
  end

  def handle_response({:ok, %HTTPoison.Response{body: body, status_code: 404}}) do
    msg = Map.get(Poison.Parser.parse!(body), "error_msg")
    {:error, msg}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, Poison.Parser.parse!(reason)}
  end

  @doc """
    Gets the posts value from the %Collection struct filled in by Poison.decode! in handle_response.

    Since resp is now a %Collection struct we can access the posts
    using resp.data.posts
  """
  def decode_posts({:ok, resp}) do
    resp.data.posts
  end

  @doc """
    Exits the system if there is an error in the returned response
  """
  def decode_posts({:error, error}) do
    IO.puts "Error fetching data from Write.as: #{error}"
    System.halt(2)
  end

  @doc """
    Gets the list of posts and iterate over them using for specialform

    https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1

    This section is a bit scary but hear me out:

    The posts are from decode_posts which return a list of %Post structs.
    We are just looping here using the for syntax.

    Since each post is a struct we can do post.title etc without using the horrible map syntax of post['title'] etc
  """
  def display_posts(posts) do
    for post <- posts do
      # IO.inspect post
      IO.puts "#{post.title} #{post.created}"
    end
  end
end
