defmodule PlanningPoker.Polls do
  alias PlanningPoker.Polls.Room
  alias PlanningPoker.Repo

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

  def create_room(room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  def get_room(room_id) do
    Repo.get(Room, room_id)
  end
end
