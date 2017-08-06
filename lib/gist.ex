defmodule Gistex do
  alias Gistex.API
  alias Gistex.Client

  defdelegate list(user, client \\ %Client{}), to: API

  defdelegate list_all(client \\ %Client{}, options \\ []), to: API

  defdelegate find(id, client \\ %Client{}), to: API

  defdelegate find_revision(id, sha, client \\ %Client{}), to: API

  defdelegate create(filename, content, client \\ %Client{}, options \\ []), to: API

  defdelegate create_multiple(files, client \\ %Client{}, options \\ []), to: API

  defdelegate edit(id, filename, content, client \\ %Client{}, options \\ []), to: API

  defdelegate edit_multiple(id, files, client \\ %Client{}, options \\ []), to: API

  defdelegate list_commits(id, client \\ %Client{}), to: API

  defdelegate star(id, client \\ %Client{}), to: API

  defdelegate unstar(id, client \\ %Client{}), to: API

  defdelegate fork(id, client \\ %Client{}), to: API

  defdelegate list_forks(id, client \\ %Client{}), to: API

  defdelegate destroy(id, client \\ %Client{}), to: API
end
