class RenameClients < ActiveRecord::Migration
  def up
    rename_table :clients, :apps
  end

  def down
    rename_table :apps, :clients
  end
end
