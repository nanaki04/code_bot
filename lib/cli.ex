defmodule CodeBot.CLI do

  @type args :: [String.t]
  @type input :: :help | {String.t, String.t}

  @spec main(args) :: :ok
  def main(args) do
    parse_args(args)
    |> process
  end

  @spec parse_args(args) :: input
  def parse_args(args) do
    parse = OptionParser.parse(args,
      switches: [help: :boolean],
      aliases: [h: :help]
    )

    case parse do
      {[help: true], _, _} -> :help
      {_, [input_file, output_language], _} -> {input_file, output_language}
      _ -> :help
    end
  end

  @spec process(input) :: :ok
  def process(:help) do
    IO.puts """
    usage: cbot <input_file> <output_language>

    supported input files:
      - (default) [.uml, .plantuml, .plnt] plant uml syntax
      - [.ez] basic syntax, fast to write class definition script

    supported output languages:
      - c#
      - unity (alias: u#) c# for unity
      - php
      - uml (plant uml)

    options:
    -h    [--help] display this help
    """
  end

  def process({input_file, output_language}) do
    input_file
    |> parse_input
    |> generate_output(output_language)
  end

  @spec parse_input(String.t) :: CodeParserState.state
  def parse_input(input_file) do
    IO.puts("parsing input")
    case hd(Regex.run(~r/(?<=\.)\w+/, input_file)) do
      "uml" -> PlantUmlParser.parse(input_file)
      "plantuml" -> PlantUmlParser.parse(input_file)
      "plnt" -> PlantUmlParser.parse(input_file)
      "ez" -> EzParser.parse(input_file)
      _ -> PlantUmlParser.parse(input_file)
    end
  end

  @spec generate_output(CodeParserState.state, String.t) :: :ok
  def generate_output(code_parser_state, "c#") do
    IO.puts("generating cs files")
    CSharpCodeGenerator.generate(code_parser_state, root: File.cwd!())
    IO.puts("output generated in: " <> File.cwd!())
  end

  def generate_output(code_parser_state, "u#"), do: generate_for_unity code_parser_state
  def generate_output(code_parser_state, "unity"), do: generate_for_unity code_parser_state
  def generate_output(code_parser_state, "uml"), do: generate_plant_uml code_parser_state

  def generate_output(code_parser_state, "php") do
    IO.puts("generating php files")
    PhpCodeGenerator.generate(code_parser_state, root: File.cwd!())
    IO.puts("output generated in: " <> File.cwd!())
  end

  def generate_output(_, language) do
    IO.puts "ERROR: the output language " <> language <> " unfortunately is unsupported at the moment"
  end

  @spec generate_plant_uml(CodeParserState.state) :: :ok
  def generate_plant_uml(code_parser_state) do
    IO.puts("generating plant uml")
    PlantUMLGenerator.generate(code_parser_state, root: File.cwd!())
    IO.puts("output generated in: " <> File.cwd!())
  end

  @spec generate_for_unity(CodeParserState.state) :: :ok
  def generate_for_unity(code_parser_state) do
    IO.puts("generating cs files for unity")
    CSharpCodeGenerator.generate_for_unity(code_parser_state, root: File.cwd!())
    IO.puts("output generated in: " <> File.cwd!())
  end

end
