defmodule TotalRecallWeb.RoutineController do
  use TotalRecallWeb, :controller

  alias TotalRecall.Routines
  alias TotalRecall.Routines.Routine
  alias TotalRecall.Routines.Question

  def new(conn, _params) do
    changeset = Routines.change_routine(%Routine{questions: [%Question{}]})
    render(conn, "new.html", changeset: changeset)
  end
end
