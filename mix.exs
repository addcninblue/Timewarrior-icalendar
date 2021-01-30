defmodule TimewIcal.MixProject do
  use Mix.Project

  def project do
    [
      app: :timew_ical,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TimewIcal, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:icalendar, "~> 1.1"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
