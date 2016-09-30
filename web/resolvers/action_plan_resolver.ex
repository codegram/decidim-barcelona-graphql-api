defmodule DecidimGraphqlApi.ActionPlanResolver do
  @endpoint "http://192.168.1.76:3000/api/action_plans"

  def all(args = %{participatory_process_id: participatory_process_id}, info) do
    case HTTPotion.get @endpoint <> ".json?participatory_process_id=#{participatory_process_id}" do
      %HTTPotion.Response{body: body} -> 
        %{action_plans: action_plans} = Poison.decode!(body, keys: :atoms)

        {:ok, categories } = DecidimGraphqlApi.CategoryResolver.all(args, info)

        action_plans = 
          Enum.map(action_plans, &(Task.async(fn() -> get_category(&1, categories) end)))
          |> Enum.map(&Task.await/1)

        {:ok, action_plans}
      %HTTPotion.ErrorResponse{message: message} ->
        {:error, "Connection error: #{message}"}
    end
  end

  defp get_category(action_plan = %{category_id: category_id}, categories) do
    category = Enum.find categories, fn (category) -> category.id == category_id end
    Map.put action_plan, :category, category
  end
end