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
  def process_request_body(body), do: Poison.encode!(body)

  def list(user) do
    get!("/users/#{user}/gists").body
  end

  def create(content, filename \\ "a.ex", options \\ []) do
    create_multiple(%{filename => content}, options)
  end

  def create_multiple(files, options \\ []) do
    post!("/gists", Enum.into(options, %{files: files})).body
  end
end
