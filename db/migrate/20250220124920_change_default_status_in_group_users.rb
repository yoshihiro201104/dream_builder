class ChangeDefaultStatusInGroupUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :group_users, :status, 0
  end
end
