defmodule TotalRecall.Routines do
  @moduledoc """
  The Routines context.
  """

  import Ecto.Query, warn: false
  alias TotalRecall.Repo

  alias TotalRecall.Routines.Routine
  alias TotalRecall.Routines.Question
  alias TotalRecall.Accounts

  @doc """
  Returns the list of routines.

  ## Examples

      iex> list_routines()
      [%Routine{}, ...]

  """
  def list_routines do
    Repo.all(Routine)
  end

  def list_routines(user) do
    from(r in Routine, where: [user_id: ^user.id], order_by: [asc: :id])
    |> Repo.all()
  end

  @doc """
  Gets a single routine.

  Raises `Ecto.NoResultsError` if the Routine does not exist.

  ## Examples

      iex> get_routine!(123)
      %Routine{}

      iex> get_routine!(456)
      ** (Ecto.NoResultsError)

  """
  def get_routine!(id) do
    Repo.get!(Routine, id)
    |> Repo.preload(questions: from(q in Question, order_by: q.id))
  end

  def get_routine!(user, id), do: Repo.get_by!(Routine, user_id: user.id, id: id)

  @doc """
  Creates a routine.

  ## Examples

      iex> create_routine(%{field: value})
      {:ok, %Routine{}}

      iex> create_routine(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_routine(%Accounts.User{} = user, attrs \\ %{}) do
    %Routine{}
    |> Routine.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a routine.

  ## Examples

      iex> update_routine(routine, %{field: new_value})
      {:ok, %Routine{}}

      iex> update_routine(routine, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_routine(%Routine{} = routine, attrs) do
    routine
    |> Routine.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a routine.

  ## Examples

      iex> delete_routine(routine)
      {:ok, %Routine{}}

      iex> delete_routine(routine)
      {:error, %Ecto.Changeset{}}

  """
  def delete_routine(%Routine{} = routine) do
    Repo.delete(routine)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking routine changes.

  ## Examples

      iex> change_routine(routine)
      %Ecto.Changeset{data: %Routine{}}

  """
  def change_routine(%Routine{} = routine, attrs \\ %{}) do
    Routine.changeset(routine, attrs)
  end

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end
end
