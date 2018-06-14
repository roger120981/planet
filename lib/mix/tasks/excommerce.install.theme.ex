defmodule Mix.Tasks.Excommerce.Install.Theme do
  use Mix.Task

  require Logger

  import Mix.Ecto

  alias Excommerce.Themes

  @base_path "priv/themes"
  @config_filename "theme.json"

  def run(args) do
    options = parse_args(args)

    ensure_started(Excommerce.Repo, [])

    if options[:local] do
      if !options[:skip_download] do
        {:ok, _} = copy_theme(options[:target])
      end
    else
      if !options[:skip_download] do
        {:ok, _} = clone_theme(options[:target])
      end
    end

    with {:ok, config} <- theme_config(options[:target]),
         :ok <- copy_assets(options[:target]),
         {:ok, theme} <- create_or_update_theme(config) do
      Logger.info("Theme #{theme.name} installed successfully!")
    else
      err -> Mix.raise("#{inspect err}")
    end
  end

  defp create_or_update_theme(theme_params) do
    if theme = Themes.get_theme(alias: theme_params["alias"]) do
      Themes.update_theme(theme, theme_params)
    else
      Themes.create_theme(theme_params)
    end
  end

  defp copy_theme(dir) do
    dest = Path.join(@base_path, theme_alias(dir))

    Task.async(fn ->
      cmd("cp", ["-rf", dir, dest])
    end)
    |> Task.await()
  end

  defp clone_theme(repo) do
    dest = Path.join(@base_path, theme_alias(repo))

    Task.async(fn ->
      cmd("git", ["clone", repo, dest])
    end)
    |> Task.await()
  end

  defp theme_config(target) do
    path = Path.join([@base_path, theme_alias(target), @config_filename])

    with {:ok, config} <- File.read(path) do
      config = config
      |> Poison.decode!()
      |> Map.merge(%{
        "alias" => theme_alias(target)
      })

      {:ok, config}
    end
  end

  defp theme_alias(repo), do: Path.basename(repo, ".git")

  defp copy_assets(repo) do
    orig_path = Path.join([@base_path, theme_alias(repo), "assets"])
    dest_path = Path.join("priv/static/themes", theme_alias(repo))

    with {:ok, _} <- cmd("mkdir", ["-p", "priv/static/themes"]),
         {:ok, _} <- cmd("cp", ["-rf", orig_path, dest_path]), do: :ok
  end

  defp cmd(command, args) do
    Task.async(fn ->
      {output, exit_status} = System.cmd(command, args)

      output = String.replace(output, "\n", "")

      if exit_status != 0 do
        {:error, output}
      else
        {:ok, output}
      end
    end)
    |> Task.await(:infinity)
  end

  defp parse_args(argv) do
    {flags, params} = OptionParser.parse!(argv, strict: [
      local: :boolean,
      skip_download: :boolean
    ])

    flags ++ [target: Enum.at(params, 0)]
  end
end
