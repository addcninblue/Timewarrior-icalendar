defmodule TimewIcal do
  @moduledoc """
  Documentation for `TimewIcal`.
  """
  use Application

  @port Application.fetch_env!(:timew_ical, :port)

  def start(_type, _args) do
    children = [{Plug.Cowboy, scheme: :http, plug: TimewIcal.Server, options: [port: @port]}]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
