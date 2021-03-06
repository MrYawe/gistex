defmodule Gistex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :gistex,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Gistex",
      source_url: "https://github.com/MrYawe/gistex"
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [:logger],
      env: [endpoint: "https://api.github.com"]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.12"},
      {:poison, "~> 3.1"},
      {:bypass, "~> 0.7", only: :test}
    ]
  end

  defp description do
    """
    A simple gist client for Elixir.
    """
  end

  defp package do
    [
      name: :gistex,
      maintainers: ["Yannis Weishaupt"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/MrYawe/gistex"}
    ]
  end
end
