class SplitFullName < ActiveRecord::Migration
  class User < ActiveRecord::Base; end

  def up
    add_column :users, :first_name, :string, after: :email
    add_column :users, :last_name,  :string, after: :first_name

    User.find_each do |user|
      name_chunks = user.full_name.split(' ')
      user.update_attributes!(first_name: name_chunks.shift, last_name: name_chunks.join(' '))
    end

    change_column :users, :first_name, :string, null: false
    change_column :users, :last_name,  :string, null: false
    remove_column :users, :full_name
  end

  def down
    add_column :users, :full_name, :string, after: :email

    User.find_each do |user|
      user.update_attributes!(full_name: "#{user.first_name} #{user.last_name}")
    end

    change_column :users, :full_name,  :string, null: false
    remove_column :users, :first_name, :last_name
  end
end
