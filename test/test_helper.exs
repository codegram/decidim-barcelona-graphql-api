ExUnit.start

Mix.Task.run "ecto.create", ~w(-r DecidimGraphqlApi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r DecidimGraphqlApi.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(DecidimGraphqlApi.Repo)

