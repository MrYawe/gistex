defmodule Gistex.CLI do
  def main(args \\ []) do
    args
    |> parse_args
    |> response
    |> IO.puts
  end

  defp parse_args(args) do
    {opts, word, _} =
      args
      |> OptionParser.parse(switches: [upcase: :boolean])

    {opts, List.to_string(word)}
  end

  defp response({opts, word}) do
    if opts[:upcase], do: String.upcase(word), else: word
  end

  defp pretty_gist(gist) do
    public = if gist["public"], do: "", else: "(secret)"
    description = if gist["description"] != "", do: gist["description"], else: Map.keys(gist["files"]) |> Enum.join(" ")
    "#{gist["html_url"]} #{String.replace(description, "\n", " ")} #{public} \n"
  end

  defp pretty_gists(gists) do
    gists
    |> Enum.map(&pretty_gist/1)
  end
end
