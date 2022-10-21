defmodule PlanningPoker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add(:identifier, :string, null: false)
      add(:history_point, :integer)
      add(:room_id, references(:rooms, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(index(:tasks, [:room_id]))
  end
end
