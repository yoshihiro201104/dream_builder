class AddStatusToGroupUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :group_users, :status, :integer
  end
end
