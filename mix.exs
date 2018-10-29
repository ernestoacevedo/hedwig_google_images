defmodule HedwigGoogleImages.MixProject do
  use Mix.Project

  def project do
    [
      app: :hedwig_google_images,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hedwig, "~> 1.0"},
      {:httpoison, "~> 0.11.2"},
      {:poison, "~> 3.1"},
      {:runtime_config, "~> 0.1.0"},
    ]
  end
end