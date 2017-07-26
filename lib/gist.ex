defmodule Gistex do
  alias Gistex.API

  defdelegate list(user), to: API

  defdelegate list_all(options \\ []), to: API

  defdelegate find(id), to: API

  defdelegate find(id, sha), to: API

  defdelegate create(content, filename \\ "a.ex", options \\ []), to: API

  defdelegate create_multiple(files, options \\ []), to: API

  defdelegate edit(id, content, filename \\ "a.ex", options \\ []), to: API

  defdelegate edit_multiple(id, files, options \\ []), to: API

  defdelegate list_commits(id), to: API

  defdelegate star(id), to: API

  defdelegate unstar(id), to: API

  defdelegate fork(id), to: API

  defdelegate list_forks(id), to: API

  defdelegate destroy(id), to: API
end
