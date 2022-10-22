defmodule PlanningPokerWeb.RoomController do
  use PlanningPokerWeb, :controller

  alias PlanningPoker.Polls
  alias PlanningPoker.Polls.Room

  def index(conn, _params) do
    user = conn.assigns.current_user

    rooms = Polls.list_rooms_by_user(user.id)

    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _parms) do
    room_changeset = Polls.room_changeset(%Room{})

    render(conn, "new.html", room_changeset: room_changeset)
  end

  def create(conn, %{"room" => room_params}) do
    current_user = conn.assigns.current_user

    case Polls.create_room(current_user, room_params) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Room created sucessfuly!")
        |> redirect(to: Routes.room_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Room cannot be created")
        |> render("new.html", room_changeset: changeset)
    end
  end

  def show(conn, %{"id" => room_id}) do
    room = Polls.get_room(room_id)

    render(conn, "show.html", room: room)
  end

  def delete(conn, %{"id" => room_id}) do
    case Polls.delete_room(room_id) do
      {1, _} ->
        conn
        |> put_flash(:info, "Room deleted sucessfuly")
        |> redirect(to: Routes.room_path(conn, :index))

      _ ->
        conn
        |> put_flash(:error, "Room cannot be deleted")
        |> redirect(to: Routes.room_path(conn, :index))
    end
  end
end
