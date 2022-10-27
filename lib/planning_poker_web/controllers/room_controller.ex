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
        rooms = Polls.list_rooms_by_user(current_user.id)

        conn
        |> put_flash(:error, "Room cannot be created")
        |> render("index.html", room_changeset: changeset, rooms: rooms)
    end
  end

  def show(conn, %{"id" => room_id}) do
    room = Polls.get_room(room_id)
    [current_task | other_tasks] = room.tasks
    users = Polls.get_users()

    render(conn, "show.html",
      room: room,
      current_task: current_task,
      other_tasks: other_tasks,
      users: users
    )
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

  def create_task(conn, %{"room_id" => room_id, "task" => task_params}) do
    case Polls.create_task(room_id, task_params) do
      {:ok, %Polls.Task{} = task} ->
        conn
        |> put_flash(:info, "Task #{task.identifier} created successfully")
        |> redirect(to: Routes.room_path(conn, :show, room_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        room = Polls.get_room(room_id)

        conn
        |> put_flash(:error, "Task cannot be created")
        |> render("show.html", changeset: changeset, room: room)
    end
  end
end
