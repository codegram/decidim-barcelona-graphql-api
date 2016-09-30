defmodule DecidimGraphqlApi.CategoryResolver do
  @endpoint "http://192.168.1.76:3000/api/categories"

  def all(%{participatory_process_id: participatory_process_id}, _info) do
    case HTTPotion.get @endpoint <> ".json?participatory_process_id=#{participatory_process_id}" do
      %HTTPotion.Response{body: body} -> 
        %{categories: categories} = Poison.decode!(body, keys: :atoms)
        {:ok, categories}
      %HTTPotion.ErrorResponse{message: message} ->
        {:error, "Connection error: #{message}"}
    end
  end
end