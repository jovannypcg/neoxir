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

  defp auth do
    encoded = @neo4j_user <> ":" <> @neo4j_pass
      |> Base.encode64

    "Basic " <> encoded
  end
end
