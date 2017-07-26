defmodule Gistex.API do
  import Gistex.Request

  def list(user) do
    get("/users/#{user}/gists")
  end

  def list_all(options \\ []) do
    get("/gists/public", options)
  end

  def find(id) do
    get("/gists/#{id}")
  end

  def find(id, sha) do
    get("/gists/#{id}/#{sha}")
  end

  def create(content, filename \\ "a.ex", options \\ []) do
    create_multiple(%{filename => content}, options)
  end

  def create_multiple(files, options \\ []) do
    post("/gists", Enum.into(options, %{files: files}))
  end

  def edit(id, content, filename \\ "a.ex", options \\ []) do
    edit_multiple(id, %{filename => content}, options)
  end

  def edit_multiple(id, files, options \\ []) do
    post("/gists/#{id}", Enum.into(options, %{files: files}))
  end

  def list_commits(id) do
    get("/gists/#{id}/commits")
  end

  def star(id) do
    put("/gists/#{id}/star")
  end

  def unstar(id) do
    delete("/gists/#{id}/star")
  end

  def fork(id) do
    post("/gists/#{id}/forks", nil)
  end

  def list_forks(id) do
    get("/gists/#{id}/forks")
  end

  def destroy(id) do
    delete("/gists/#{id}")
  end
end
