defmodule Neoxir.Neo4j do
  use HTTPoison.Base

  @neo4j_url Application.get_env(:neoxir, :neo4j_url)
  @neo4j_user Application.get_env(:neoxir, :neo4j_user)
  @neo4j_pass Application.get_env(:neoxir, :neo4j_pass)

  @moduledoc """
  Provides functions to play with Neo4j, such as creating nodes, labes,
  relatiships and retrieve them.
  """

  @doc """
  Gets the authentication string for consuming the neo4j api, which requires
  a basic authorization header.
  """
  defp auth_value() do
    encoded = @neo4j_user <> ":" <> @neo4j_pass
      |> Base.encode64

    "Basic " <> encoded
  end
end
