defmodule IrisClassiferMl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      IrisClassiferMlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: IrisClassiferMl.PubSub},
      # Start the Endpoint (http/https)
      IrisClassiferMlWeb.Endpoint
      # Start a worker by calling: IrisClassiferMl.Worker.start_link(arg)
      # {IrisClassiferMl.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IrisClassiferMl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IrisClassiferMlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
