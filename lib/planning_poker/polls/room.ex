defmodule PlanningPoker.Polls.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias PlanningPoker.Accounts.User

  schema "rooms" do
    field :name, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(room, attrs \\ %{}) do
    room
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
