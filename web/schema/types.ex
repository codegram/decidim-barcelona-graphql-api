defmodule DecidimGraphqlApi.Schema.Types do
  use Absinthe.Schema.Notation

  object :proposal do
    field :id, :id
    field :title, :string
    field :url, :string
    field :summary, :string
    field :author, :author
  end

  object :author do
    field :id, :id
    field :name, :string
  end

  object :action_plan do
    field :id, :id
    field :title, :string
    field :description, :string
    field :category, :category
  end

  object :category do
    field :id, :id
    field :name, :string
  end
end