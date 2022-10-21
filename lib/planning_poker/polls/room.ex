defmodule PlanningPoker.Polls.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias PlanningPoker.Accounts.User
  alias PlanningPoker.Polls.Task

  schema "rooms" do
    field :name, :string
    belongs_to :user, User
    has_many(:tasks, Task)

    timestamps()
  end

  @doc false
  def changeset(room, attrs \\ %{}) do
    room
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
