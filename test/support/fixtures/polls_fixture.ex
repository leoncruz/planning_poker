defmodule PlanningPoker.PollsFixture do
  alias PlanningPoker.Accounts.User

  def generate_room_name, do: "room #{System.unique_integer()}"

  def room_fixture(%User{} = user, attrs) do
    {:ok, room} = PlanningPoker.Polls.create_room(user, room_attributes(attrs))

    room
  end

  def room_fixture(%User{} = user) do
    {:ok, room} = PlanningPoker.Polls.create_room(user, room_attributes(%{}))

    room
  end

  def room_fixture(Map = attrs) do
    {:ok, room} =
      user_fixture()
      |> PlanningPoker.Polls.create_room(room_attributes(attrs))

    room
  end

  def room_fixture do
    {:ok, room} =
      user_fixture()
      |> PlanningPoker.Polls.create_room(room_attributes())

    room
  end

  def room_attributes(attrs \\ %{}) do
    Enum.into(
      attrs,
      %{name: generate_name()}
    )
  end

  defp user_fixture do
    PlanningPoker.AccountsFixtures.user_fixture()
  end

  defp generate_name do
    "room ##{System.unique_integer()}"
  end
end
