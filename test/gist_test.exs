defmodule GistexTest do
  use ExUnit.Case, async: true
  alias Gistex.Client

  setup do
    bypass = Bypass.open
    Application.put_env(:gist,
      :endpoint, "http://localhost:#{bypass.port}")
    {:ok, bypass: bypass}
  end

  test "the truth", %{bypass: bypass} do
    Bypass.expect_once(bypass, &Plug.Conn.send_resp(&1, 200, ""))
    Gistex.list("MrYawe")
  end

  describe "Gistex.list/1" do
    test "it should reach the correct request path", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/users/MrYawe/gists"
        Plug.Conn.resp(conn, 200, "")
      end)
      Gistex.list("MrYawe")
    end
  end

  describe "Gistex.create/3" do
    test "it should reach the correct request path", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/gists"
        Plug.Conn.resp(conn, 200, "")
      end)
      Gistex.create("Hello world", "hello_world.txt")
    end

    test "the request's body should include files param", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        json = Poison.decode!(body)
        assert json ==  %{"files" => %{"hello_world.txt" => "Hello world"}}
        Plug.Conn.resp(conn, 200, "")
      end)
      Gistex.create("hello_world.txt", "Hello world")
    end

    test "it should accept options", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        json = Poison.decode!(body)
        assert json["description"] == "My description"
        assert json["public"] == true
        Plug.Conn.resp(conn, 200, "")
      end)
      Gistex.create("hello_world.txt", "Hello world", %Client{},
        description: "My description", public: true)
    end
  end
end
