defmodule Neoxir do
  @neo4j_url Application.get_env(:neoxir, :neo4j_url)

  import Neoxir.Request

  @moduledoc """
  Provides functions to play with Neo4j, such as creating nodes, labes,
  relatiships and retrieve them.
  """

  @doc """
  Creates a single node in Neo4j
  """
  def create_node(properties \\ %{}) do
    {:ok, request_body } = Poison.encode(properties)

    HTTPoison.post!(@neo4j_url <> "/db/data/node", request_body, headers)
      |> response_body
      |> Poison.decode
      |> poison_decoded_value
  end

  @doc """
  Creates a single node with a label in Neo4j
  """
  def create_node(properties, label) do
    create_node(properties)
      |> node_id_from_response
      |> set_node_label(label)
      |> get_node
  end

  @doc """
  Gets a single node from the database
  """
  def get_node(node_id) do
    url = @neo4j_url <> "/db/data/node/#{node_id}"

    HTTPoison.get!(url, headers)
      |> response_body
      |> Poison.decode
      |> poison_decoded_value
  end

  defp set_node_label(node_id, label) do
    labels_url = @neo4j_url <> "/db/data/node/#{node_id}/labels"
    {:ok, request_body } = Poison.encode(label)

    HTTPoison.post!(labels_url, request_body, headers)
      |> response_body

    node_id
  end

  defp poison_decoded_value({ :ok, decoded_value }), do: decoded_value
end
