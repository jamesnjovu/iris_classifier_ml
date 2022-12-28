import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :iris_classifer_ml, IrisClassiferMlWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xOSC93bsPQIMAkGYpo+N/QtbxFehAikA2wpbeh+u1UbH3BIOd6XgN8Jk6Jy+jxOd",
  server: false

# In test we don't send emails.
config :iris_classifer_ml, IrisClassiferMl.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
