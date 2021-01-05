defmodule TotalRecall.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :body, :string
      add :routine_id, references(:routines, on_delete: :nothing)

      timestamps()
    end

    create index(:questions, [:routine_id])
    create unique_index(:questions, [:routine_id, :body], name: :index_routine_question)
  end
end
