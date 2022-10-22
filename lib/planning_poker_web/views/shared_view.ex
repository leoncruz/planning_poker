defmodule PlanningPokerWeb.SharedView do
  use PlanningPokerWeb, :view

  def modal(assigns \\ %{}, do: block), do: render_template("modal.html", assigns, block)

  defp render_template(template, assigns, block) do
    assigns =
      assigns
      |> Map.put(:inner_content, block)

    render(template, assigns)
  end
end
