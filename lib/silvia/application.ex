defmodule Silvia.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    Logger.info("[#{inspect(__MODULE__)}] starting Silvia Application")

    Silvia.WifiWizard.setup_wifi_if_necessary()

    children =
      [
        # Start the Telemetry supervisor
        SilviaWeb.Telemetry,
        # Start the PubSub system
        {Phoenix.PubSub, name: Silvia.PubSub},
        # Start the Endpoint (http/https)
        SilviaWeb.Endpoint,
        # Start a worker by calling: Silvia.Worker.start_link(arg)
        # {Silvia.Worker, arg}

        Silvia.Controller,
        Silvia.WifiChecker,
        Silvia.BoilerTemperature,
        Silvia.Dashboard
      ] ++ children(target())

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Silvia.Supervisor]
    Logger.info("[#{inspect(__MODULE__)}] starting Silvia Supervisor")
    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: Silvia.Worker.start_link(arg)
      # {Silvia.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: Silvia.Worker.start_link(arg)
      # {Silvia.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:silvia, :target)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SilviaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
