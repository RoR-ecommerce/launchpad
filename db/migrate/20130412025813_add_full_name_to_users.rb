class AddFullNameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :full_name, :string, null: false
  end

  def down
    remove_column :users, :full_name
  end
end
