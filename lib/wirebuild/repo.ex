defmodule Wirebuild.Repo do
  use Ecto.Repo,
    otp_app: :wirebuild,
    adapter: Ecto.Adapters.Postgres
end
