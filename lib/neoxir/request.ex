defmodule Neoxir.Request do
  @neo4j_user Application.get_env(:neoxir, :neo4j_user)
  @neo4j_pass Application.get_env(:neoxir, :neo4j_pass)

  @doc """
  Provides the headers for making calls to the neo4j API.
  """
  def headers do
      %{
        "Content-Type" => "application/json; charset=UTF-8",
        "Authorization" => auth,
        "Accept": "application/json; charset=UTF-8"
      }
  end

  @doc """
  Returns the body of a POST response, whose status code is the specified
  """
  def response_body(%{status_code: 200, body: body}), do: body
  def response_body(%{status_code: 201, body: body}), do: body
  def response_body(%{status_code: 204, body: body}), do: body
  def response_body(%{status_code: 404, body: _}) do
    {:ok, encoded_value} = %{:error => "Object Not found"}
      |> Poison.encode

    encoded_value
  end
  def response_body(%{status_code: _, body: body}), do: { :error, body }

  @doc """
  Gets the ID of the node from a Neo4j response.
  """
  def node_id_from_response(body) do
    body["metadata"]["id"]
  end

  defp auth do
    encoded = @neo4j_user <> ":" <> @neo4j_pass
      |> Base.encode64

    "Basic " <> encoded
  end
end
