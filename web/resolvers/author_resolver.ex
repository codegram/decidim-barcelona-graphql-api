defmodule DecidimGraphqlApi.AuthorResolver do
  @endpoint "http://192.168.1.76:3000/api/authors"

  def find (id) do
    case HTTPotion.get @endpoint <> "/#{id}.json" do
      %HTTPotion.Response{body: body} ->
        %{user: author} = Poison.decode!(body, keys: :atoms)
        author
    end
  end
end