defmodule Neoxir do
  @neo4j_url Application.get_env(:neoxir, :neo4j_url)

  import Neoxir.Request, only: [headers: 0]

  @moduledoc """
  Provides functions to play with Neo4j, such as creating nodes, labes,
  relatiships and retrieve them.
  """

  @doc """
  Creates a single node in Neo4j
  """
  def create_single_node(properties \\ %{}) do
    json_request = properties
      |> Poison.encode
      |> json_properties

    HTTPoison.post!(@neo4j_url <> "/db/data/node", json_request, headers)
  end

  defp json_properties({:ok, body}), do: body
end
