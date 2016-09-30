defmodule DecidimGraphqlApi.Schema do
  use Absinthe.Schema
  import_types DecidimGraphqlApi.Schema.Types

  query do
    field :proposals, list_of(:proposal) do
      arg :participatory_process_id, non_null(:string)
      resolve &DecidimGraphqlApi.ProposalResolver.all/2
    end

    field :action_plans, list_of(:action_plan) do
      arg :participatory_process_id, non_null(:string)
      resolve &DecidimGraphqlApi.ActionPlanResolver.all/2
    end
  end
end