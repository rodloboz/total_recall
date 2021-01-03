defmodule TotalRecall.Repo do
  use Ecto.Repo,
    otp_app: :total_recall,
    adapter: Ecto.Adapters.Postgres
end
