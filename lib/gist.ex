defmodule Gist do
  use HTTPoison.Base

  @moduledoc """
  Documentation for Gist.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Gist.hello
      :world

  """
  @api_base_url "https://api.github.com"
  @api_version "v3"

  # require IEx; IEx.pry

  # Helper, to request directly with the path
  def process_url(url), do: @api_base_url <> url

  # We decode the JSON body for every requests
  def process_response_body(body), do: Poison.decode!(body)

  def list_gists(user \\ "") do
    get!("/users/#{user}/gists").body
    |> pretty_gist
    |> IO.puts
  end

  defp pretty_gist(response) do
    response
    |> Enum.map(fn gist ->
      public = if gist["public"], do: "", else: "(secret)"
      description = if gist["description"] != "", do: gist["description"], else: Map.keys(gist["files"]) |> Enum.join(" ")
      "#{gist["html_url"]} #{String.replace(description, "\n", " ")} #{public} \n"
    end)
  end
end
