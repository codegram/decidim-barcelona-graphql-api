defmodule DecidimGraphqlApi.ProposalResolver do
  @endpoint "http://192.168.1.76:3000/api/proposals"

  def all(%{participatory_process_id: participatory_process_id}, _info) do
    case HTTPotion.get @endpoint <> ".json?participatory_process_id=#{participatory_process_id}" do
      %HTTPotion.Response{body: body} -> 
        %{proposals: proposals} = Poison.decode!(body, keys: :atoms)

        proposals = 
          Enum.map(proposals, &(Task.async(fn() -> get_proposal_author(&1) end)))
          |> Enum.map(&Task.await/1)

        {:ok, proposals}
      %HTTPotion.ErrorResponse{message: message} ->
        {:error, "Connection error: #{message}"}
    end
  end

  defp get_proposal_author (proposal = %{author_id: author_id}) do
    if author_id do
      Map.put proposal, :author, DecidimGraphqlApi.AuthorResolver.find(author_id)
    else
      proposal
    end
  end
end