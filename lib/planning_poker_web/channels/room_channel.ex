defmodule PlanningPokerWeb.RoomChannel do
  use PlanningPokerWeb, :channel

  @impl true
  def join("room:" <> room_id, payload, socket) do
    if authorized?(payload) do
      send(self(), {:after_join, room_id})
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  @impl true
  def handle_in("poll", _payload, socket) do
    broadcast(socket, "poll", %{"body" => "voted"})
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  @impl true
  def handle_info({:after_join, room_id}, socket) do
    user_id = socket.assigns.user
    broadcast(socket, "room:#{room_id}", %{"body" => "user #{user_id} joined"})
    {:noreply, socket}
  end
end
