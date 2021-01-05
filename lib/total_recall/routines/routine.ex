defmodule TotalRecall.Routines.Routine do
  use Ecto.Schema
  import Ecto.Changeset

  schema "routines" do
    field :name, :string
    field :active, :boolean
    belongs_to :user, TotalRecall.Accounts.User
    has_many :questions, TotalRecall.Routines.Question, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(routine, attrs \\ %{}) do
    routine
    |> cast(attrs, [:name])
    |> cast_assoc(:questions, required: true)
    |> validate_required([:name])
  end
end
