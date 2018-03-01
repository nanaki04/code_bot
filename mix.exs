defmodule CodeBot.Mixfile do
  use Mix.Project

  def project do
    [
      app: :code_bot,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      escript: [main_module: CodeBot.CLI, name: "cbot"],
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
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.16", only: [:dev], runtime: false},
      {:plant_uml_parser, git: "https://github.com/nanaki04/plant_uml_parser.git"},
      {:ez_parser, git: "https://github.com/nanaki04/ez_parser.git"},
      {:c_sharp_code_generator, git: "https://github.com/nanaki04/c_sharp_code_generator.git"},
    ]
  end
end
