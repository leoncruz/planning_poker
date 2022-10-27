defmodule PlanningPoker.Polls do
  alias PlanningPoker.Polls.{Room, Task}
  alias PlanningPoker.Repo
  alias PlanningPoker.Accounts.User

  import Ecto.Query

  def list_rooms_by_user(user_id) do
    query =
      from r in Room,
        where: r.user_id == ^user_id

    Repo.all(query)
  end

  def room_changeset(room, params \\ %{}) do
    Room.changeset(room, params)
  end

  def create_room(current_user, room_attrs) do
    current_user
    |> Ecto.build_assoc(:rooms, room_attrs)
    |> Room.changeset(room_attrs)
    |> Repo.insert()
  end

  def get_room(room_id) do
    query =
      from r in Room,
        where: r.id == ^room_id,
        preload: [:tasks]

    Repo.one(query)
  end

  def delete_room(room_id) do
    query = from r in Room, where: r.id == ^room_id

    Repo.delete_all(query)
  end

  def task_changeset(room_id, params \\ %{}) do
    room_id
    |> get_room()
    |> Ecto.build_assoc(:tasks, params)
    |> Task.changeset(params)
  end

  def create_task(room_id, params) do
    task_changeset(room_id, params)
    |> Repo.insert()
  end

  def get_users do
    Repo.all(User)
  end
end
