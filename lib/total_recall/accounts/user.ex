defmodule TotalRecall.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :full_name, :string
    field :github, :string
    field :twitter, :string
    field :username, :string
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :encrypted_password, :full_name, :twitter, :github, :website])
    |> validate_required([:username, :email, :encrypted_password, :full_name, :twitter, :github, :website])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
