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
  @api_version "v3"

  # require IEx; IEx.pry

  defp endpoint, do: Application.fetch_env!(:gist, :endpoint)

  # Helper, to request directly with the path
  def process_url(url), do: endpoint() <> url

  def process_response_body(""), do: nil
  def process_response_body(body), do: Poison.decode!(body)

  def process_request_body(body), do: Poison.encode!(body)

  def list!(user) do
    get!("/users/#{user}/gists").body
  end

  def list_all!(options \\ []) do
    get!("/gists/public", [], params: options).body
  end

  def get!(id) do
    get!("/gists/#{id}").body
  end

  def get!(id, sha) do
    get!("/gists/#{id}/#{sha}").body
  end

  def create!(content, filename \\ "a.ex", options \\ []) do
    create_multiple!(%{filename => content}, options)
  end

  def create_multiple!(files, options \\ []) do
    post!("/gists", Enum.into(options, %{files: files})).body
  end

  def edit!(id, content, filename \\ "a.ex", options \\ []) do
    edit_multiple!(id, %{filename => content}, options)
  end

  def edit_multiple!(id, files, options \\ []) do
    post!("/gists/#{id}", Enum.into(options, %{files: files})).body
  end

  def list_commits!(id) do
    get!("/gists/#{id}/commits").body
  end

  def star!(id) do
    put!("/gists/#{id}/star").body
  end

  def unstar!(id) do
    delete!("/gists/#{id}/star").body
  end

  def fork!(id) do
    post!("/gists/#{id}/forks", nil).body
  end

  def list_forks!(id) do
    get!("/gists/#{id}/forks").body
  end

  def delete!(id) do
    delete!("/gists/#{id}").body
  end
end
