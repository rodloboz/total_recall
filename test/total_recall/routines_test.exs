defmodule TotalRecall.RoutinesTest do
  use TotalRecall.DataCase

  alias TotalRecall.Routines

  describe "routines" do
    alias TotalRecall.Routines.Routine

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def routine_fixture(attrs \\ %{}) do
      {:ok, routine} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Routines.create_routine()

      routine
    end

    test "list_routines/0 returns all routines" do
      routine = routine_fixture()
      assert Routines.list_routines() == [routine]
    end

    test "get_routine!/1 returns the routine with given id" do
      routine = routine_fixture()
      assert Routines.get_routine!(routine.id) == routine
    end

    test "create_routine/1 with valid data creates a routine" do
      assert {:ok, %Routine{} = routine} = Routines.create_routine(@valid_attrs)
      assert routine.name == "some name"
    end

    test "create_routine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Routines.create_routine(@invalid_attrs)
    end

    test "update_routine/2 with valid data updates the routine" do
      routine = routine_fixture()
      assert {:ok, %Routine{} = routine} = Routines.update_routine(routine, @update_attrs)
      assert routine.name == "some updated name"
    end

    test "update_routine/2 with invalid data returns error changeset" do
      routine = routine_fixture()
      assert {:error, %Ecto.Changeset{}} = Routines.update_routine(routine, @invalid_attrs)
      assert routine == Routines.get_routine!(routine.id)
    end

    test "delete_routine/1 deletes the routine" do
      routine = routine_fixture()
      assert {:ok, %Routine{}} = Routines.delete_routine(routine)
      assert_raise Ecto.NoResultsError, fn -> Routines.get_routine!(routine.id) end
    end

    test "change_routine/1 returns a routine changeset" do
      routine = routine_fixture()
      assert %Ecto.Changeset{} = Routines.change_routine(routine)
    end
  end

  describe "questions" do
    alias TotalRecall.Routines.Question

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Routines.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Routines.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Routines.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Routines.create_question(@valid_attrs)
      assert question.body == "some body"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Routines.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = Routines.update_question(question, @update_attrs)
      assert question.body == "some updated body"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Routines.update_question(question, @invalid_attrs)
      assert question == Routines.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Routines.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Routines.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Routines.change_question(question)
    end
  end
end
