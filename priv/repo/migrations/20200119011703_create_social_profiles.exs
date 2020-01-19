defmodule Wirebuild.Repo.Migrations.CreateSocialProfiles do
  use Ecto.Migration

  def change do
    create table(:social_profiles) do
      add :medium, :string
      add :dev_to, :string
      add :twitter, :string
      add :github, :string
      add :company, :string
      add :email, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:social_profiles, [:user_id])
  end
end
