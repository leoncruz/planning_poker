defmodule PlanningPoker.PollsTest do
  use PlanningPoker.DataCase

  alias PlanningPoker.Polls
  alias PlanningPoker.Polls.Room
  alias PlanningPoker.Accounts.User

  import PlanningPoker.{PollsFixture, AccountsFixtures}

  describe "list_rooms_by_user/1" do
    setup do
      user1 = user_fixture()
      user2 = user_fixture()

      room1 = room_fixture(user1)
      room2 = room_fixture(user2)

      %{room1: room1, room2: room2, user1: user1, user2: user2}
    end

    test "return only rooms for informed user", context do
      %{room1: room1, room2: room2, user1: user1, user2: user2} = context

      assert [room1] == Polls.list_rooms_by_user(user1.id)

      assert [room2] == Polls.list_rooms_by_user(user2.id)
    end
  end

  describe "room_changeset/2" do
    test "returns a room changeset" do
      assert %Ecto.Changeset{} = changeset = Polls.room_changeset(%Room{})
      assert :name in changeset.required == true
    end
  end

  describe "create_room/2" do
    test "requires a name to be created" do
      user = user_fixture()

      {:error, changeset} = Polls.create_room(user, %{})

      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires an user to be created" do
      {:error, changeset} = Polls.create_room(%User{}, %{name: "room name"})

      assert %{user_id: ["can't be blank"]} = errors_on(changeset)
    end

    test "creates a room when given attribtues are valid" do
      user = user_fixture()
      room = room_attributes()

      assert {:ok, %Room{}} = Polls.create_room(user, room)
    end
  end

  describe "get_room/1" do
    test "return nil if room_id does not exists" do
      assert nil == Polls.get_room(0)
    end

    test "return a room if room_id exists" do
      room1 = room_fixture()
      room2 = room_fixture()

      assert room1 == Polls.get_room(room1.id)
      refute room2 == Polls.get_room(room1.id)
    end
  end
end
