defmodule EHCS.UC6.Repo.Migrations.AddPushMessages do
  use Ecto.Migration

  def change do
    create table("push_messages", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :tax_id, :string, null: false
      add :template_name, :string, null: false
      add :template_parameters, :map, null: false
      add :status, :string, null: false
      add :distribution_id, :string, null: false
      add :created_at, :naive_datetime_usec, null: false
      add :status_timestamp, :naive_datetime_usec, null: false
    end
  end
end
