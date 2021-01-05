defmodule TotalRecallWeb.RoutineLive.New do
  use TotalRecallWeb, :live_view

  alias TotalRecall.Repo
  alias TotalRecall.Routines
  alias TotalRecall.Routines.Routine
  alias TotalRecall.Routines.Question

  @impl true
  def render(assigns) do
    TotalRecallWeb.RoutineView.render("new.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    changeset = Routines.change_routine(%Routine{questions: [%Question{}]})
    {:ok,
      socket
      |> assign(:changeset, changeset)
    }
  end

  @impl true
  def handle_event("validate", %{"routine" => routine_params}, socket) do
    changeset =
      %Routine{}
      |> Routines.change_routine(routine_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", _, %{assigns: %{changeset: changeset}} = socket) do
    case Repo.insert(changeset) do
      {:ok, _routine} ->
        {:noreply,
          socket
          |> push_redirect(to: Routes.user_dashboard_path(socket, :show))
        }
      {:error, changeset} ->
        {:noreply,
          socket
          |> assign(:changeset, changeset)
          |> put_flash(:error, "Could not save the routine.")
        }
    end
  end

  def handle_event("add-question", _, socket) do
    existing_questions = Map.get(socket.assigns.changeset.changes, :questions, [%Question{}])

    questions =
      existing_questions
      |> Enum.concat([
        Routines.change_question(%Question{temp_id: get_temp_id()})
      ])

    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_assoc(:questions, questions)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove-question", %{"remove" => remove_id}, socket) do
    questions =
      socket.assigns.changeset.changes.questions
      |> Enum.reject(fn %{data: question} ->
        question.temp_id == remove_id
      end)

    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_assoc(:questions, questions)

    {:noreply, assign(socket, changeset: changeset)}
  end

  defp get_temp_id, do: :crypto.strong_rand_bytes(5) |> Base.url_encode64 |> binary_part(0, 5)

  defp put_changeset(socket, params \\ %{}) do
    socket
    |> assign(:changeset, Routines.change_routine(%Routine{}, params))
  end
end
