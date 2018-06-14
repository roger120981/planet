defmodule Excommerce.Repo.Migrations.CreateUsersRoles do
  use Ecto.Migration

  def change do
    create table(:users_roles) do
      
	  add :user_id, references(:users, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :delete_all)
	  
      timestamps()
    end
    create index(:users_roles, [:user_id])
    create index(:users_roles, [:role_id])
	create unique_index(:users_roles, [:user_id, :role_id])
  end
end
