defmodule Gistex.Request do
  use HTTPoison.Base

  @moduledoc """
  Documentation for Gistex.
  """

  @api_version "v3"
  @user_agent [{"User-agent", "gistex"}]

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

  def get(path, client, params \\ []) do
    _request(:get, path, client.auth, "", [params: params])
  end

  def post(path, client, body \\ "") do
    _request(:post, path, client.auth, body)
  end

  def put(path, client, body \\ "") do
    _request(:put, path, client.auth, body)
  end

  def delete(path, client, body \\ "") do
    _request(:delete, path, client.auth, body)
  end

  defp _request(method, url, auth, body \\ "", options \\ []) do
    method
    |> request!(url, body, authorization_header(auth, @user_agent) ++ extra_headers(), options ++ extra_options())
    |> process_response
  end

  def extra_headers, do: []
  def extra_options, do: []

  @doc """
  There are two ways to authenticate through GitHub API v3:
    * Basic authentication
    * OAuth2 Token
  This function accepts both.
  ## Examples
      iex> Tentacat.authorization_header(%{user: "user", password: "password"}, [])
      [{"Authorization", "Basic dXNlcjpwYXNzd29yZA=="}]
      iex> Tentacat.authorization_header(%{access_token: "92873971893"}, [])
      [{"Authorization", "token 92873971893"}]
  ## More info
  http:\\developer.github.com/v3/#authentication
  """
  @spec authorization_header(Client.auth, list) :: list
  def authorization_header(%{user: user, password: password}, headers) do
    userpass = "#{user}:#{password}"
    IO.inspect headers
    headers ++ [{"Authorization", "Basic #{:base64.encode(userpass)}"}]
  end

  def authorization_header(%{access_token: token}, headers) do
    headers ++ [{"Authorization", "token #{token}"}]
  end

  def authorization_header(_, headers), do: headers
end
