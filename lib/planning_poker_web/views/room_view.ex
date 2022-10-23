defmodule PlanningPokerWeb.RoomView do
  use PlanningPokerWeb, :view

  def card(number) do
    content_tag :div, class: "column" do
      content_tag :div, class: "poll-card", data: [value: number] do
        content_tag :div, class: "card-content has-text-centered" do
          number
        end
      end
    end
  end
end
