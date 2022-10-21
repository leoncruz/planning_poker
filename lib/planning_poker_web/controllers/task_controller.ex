defmodule PlanningPokerWeb.TaskController do
  use PlanningPokerWeb, :controller

  alias PlanningPoker.Polls

  def new(conn, %{"room_id" => room_id}) do
    changeset = Polls.task_changeset(room_id)

    render(conn, "new.html", changeset: changeset, room_id: room_id)
  end

  def create(conn, %{"room_id" => room_id, "task" => task_params}) do
    case Polls.create_task(room_id, task_params) do
      {:ok, %Polls.Task{} = task} ->
        conn
        |> put_flash(:info, "Task #{task.identifier} created successfully")
        |> redirect(to: Routes.room_path(conn, :show, room_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)

        conn
        |> put_flash(:error, "Task cannot be created")
        |> render("new.html", changeset: changeset, room_id: room_id)
    end
  end
end
