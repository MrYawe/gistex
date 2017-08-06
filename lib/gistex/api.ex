defmodule Gistex.API do
  import Gistex.Request
  alias Gistex.Client

  def list(user, client \\ %Client{}) do
    get "/users/#{user}/gists", client
  end

  def list_all(client \\ %Client{}, options \\ []) do
    get "/gists/public", client, options
  end

  def find(id, client \\ %Client{}) do
    get "/gists/#{id}", client
  end

  def find_revision(id, sha, client \\ %Client{}) do
    get "/gists/#{id}/#{sha}", client
  end

  def create(filename, content, client \\ %Client{}, options \\ []) do
    create_multiple %{filename => content}, client, options
  end

  def create_multiple(files, client \\ %Client{}, options \\ []) do
    post "/gists", client, Enum.into(options, %{files: files})
  end

  def edit(id, filename, content, client \\ %Client{}, options \\ []) do
    edit_multiple id, %{filename => content}, client, options
  end

  def edit_multiple(id, files, client \\ %Client{}, options \\ []) do
    post "/gists/#{id}", client, Enum.into(options, %{files: files})
  end

  def list_commits(id, client \\ %Client{}) do
    get "/gists/#{id}/commits", client
  end

  def star(id, client \\ %Client{}) do
    put "/gists/#{id}/star", client
  end

  def unstar(id, client \\ %Client{})do
    delete "/gists/#{id}/star", client
  end

  def fork(id, client \\ %Client{}) do
    post "/gists/#{id}/forks", client, nil
  end

  def list_forks(id, client \\ %Client{}) do
    get "/gists/#{id}/forks", client
  end

  def destroy(id, client \\ %Client{}) do
    delete "/gists/#{id}", client
  end
end
