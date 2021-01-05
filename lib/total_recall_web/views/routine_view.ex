defmodule TotalRecallWeb.RoutineView do
  use TotalRecallWeb, :view

  require Integer

  def bg_color(index) do
    if Integer.is_even(index), do: "bg-white", else: "bg-gray-50"
  end
end
