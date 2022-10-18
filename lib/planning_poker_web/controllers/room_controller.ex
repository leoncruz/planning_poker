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
    room_changeset =
      %Room{}
      |> Polls.room_changeset()

    render(conn, "new.html", room_changeset: room_changeset)
  end

  def create(conn, %{"room" => room_params}) do
    current_user = conn.assigns.current_user

    changeset = Ecto.build_assoc(current_user, :rooms, room_params)

    case Polls.create_room(changeset, room_params) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Room created sucessfuly!")
        |> redirect(to: Routes.room_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:infor, "Room cannot be created")
        |> render("new.html", room_changeset: changeset)
    end
  end
end
