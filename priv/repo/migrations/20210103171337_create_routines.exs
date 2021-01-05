defmodule TotalRecall.Repo.Migrations.CreateRoutines do
  use Ecto.Migration

  def change do
    create table(:routines) do
      add :name, :string, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :active, :boolean, default: false, null: false

      timestamps()
    end

    create index(:routines, [:user_id])
  end
end
