defmodule PlanningPoker.Polls.Task do
  use Ecto.Schema
  import Ecto.Changeset

  alias PlanningPoker.Polls.Room

  schema "tasks" do
    field :history_point, :integer
    field :identifier, :string
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:identifier, :history_point, :room_id])
    |> validate_required([:identifier, :room_id])
  end
end
