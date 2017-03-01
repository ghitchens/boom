# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :nerves_cell, Mix.Project.config

config :nerves_leds, names: [ green: "led0" ]

config :boom, :wlan0, ssid: "boo",  key_mgmt: :"WPA-PSK",  psk: "thunderstruck"

config :logger,
        backends: [ :console, LoggerMulticastBackend ],
        level: :debug,
        format: "$time $metadata[$level] $message\n"

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"
