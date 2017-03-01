defmodule Boom.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"
  @architecture System.get_env("NERVES_ARCHITECURE") || "unknown"
  @timestamp DateTime.to_unix(DateTime.utc_now)
  @version "0.1.2-dev-#{@timestamp}"

  def project do
    [app: :boom,
     version: @version,
     architecture: @architecture,
     target: @target,
     archives: [nerves_bootstrap: "~> 0.2.1"],
     # cell config stuff
     product: "Boom - ElixirDaze Demo",
    descripton: """
    Not sure exactly what it detects, but it detects something!
    A sample project For the Raspberry Pi 3 and GrovePi board.
    """,
    author: "ElixirDaze Workshop",
    tags: "development",

     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     kernel_modules: kernel_modules(@target),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Boom, []},
     extra_applications: [:logger, :nerves_leds, :runtime_tools]]
  end

  def deps do
    [{:nerves, "~> 0.4.0"},
     {:nerves_interim_wifi, "~> 0.1"},
     {:logger_multicast_backend, "~> 0.2"},
     {:elixir_ale, "~> 0.5.7"},
     {:grovepi, github: "fhunleth/grovepi", branch: "master"},
     {:nerves_firmware_http, "~>0.3.1"},
     {:nerves_cell, github: "ghitchens/nerves_cell"},
     {:nerves_leds, "~> 0.8.0"}]
  end

  def system(target) do
    [{:"nerves_system_#{target}", ">= 0.0.0"}]
  end

  def kernel_modules("rpi3"), do: ["brcmfmac"]
  def kernel_modules(_), do: []

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
