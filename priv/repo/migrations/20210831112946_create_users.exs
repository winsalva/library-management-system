defmodule App.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :seen, :boolean, default: false
      timestamps([type: :utc_datetime_usec])
    end

    create unique_index(:users, [:email])
  end
end
