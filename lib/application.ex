defmodule September.Application do
  def start(_type, _args) do
    children = [
      {Counter, %{}}
    ]

    opts = [strategy: :one_for_one, name: September.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
