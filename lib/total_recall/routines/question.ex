defmodule TotalRecall.Routines.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :body, :string
    field :temp_id, :string, virtual: true
    field :delete, :boolean, virtual: true
    belongs_to :routine, TotalRecall.Routines.Routine

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> Map.put(:temp_id, (question.temp_id || attrs["temp_id"]))
    |> cast(attrs, [:body, :delete])
    |> validate_required([:body])
    |> unique_constraint(:body, name: :index_routine_question)
    |> maybe_mark_for_deletion()
  end

  defp maybe_mark_for_deletion(%{data: %{id: nil}} = changeset), do: changeset
  defp maybe_mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
