class AddDeletedAtToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.datetime :deleted_at
    end
  end
end
