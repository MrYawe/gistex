defmodule Gistex.Request do
  use HTTPoison.Base

  @moduledoc """
  Documentation for Gistex.
  """

  @api_version "v3"

  # require IEx; IEx.pry

  defp endpoint, do: Application.fetch_env!(:gist, :endpoint)

  # Helper, to request directly with the path
  def process_url(url), do: endpoint() <> url

  def process_request_body(body), do: Poison.encode!(body)

  def process_response_body(""), do: nil
  def process_response_body(body), do: Poison.decode!(body)

  def process_response(%HTTPoison.Response{status_code: status, body: body}) when status >= 200 and status < 300, do: body
  def process_response(%HTTPoison.Response{status_code: status, body: body }) do
    raise Gistex.Error, code: status, message: inspect body
  end

  def get(path, params \\ []) do
    _request(:get, path, "", [], [params: params])
  end

  def post(path, body \\ "") do
    _request(:post, path, body)
  end

  def put(path, body \\ "") do
    _request(:put, path, body)
  end

  def delete(path, body \\ "") do
    _request(:delete, path, body)
  end

  defp _request(method, url, body \\ "", headers \\ [], options \\ []) do
    method
    |> request!(url, body, extra_headers() ++ headers, extra_options() ++ options)
    |> process_response
  end

  def extra_headers, do: []
  def extra_options, do: []
end
