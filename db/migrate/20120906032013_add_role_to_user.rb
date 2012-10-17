class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role_cd, :integer
  end
end
