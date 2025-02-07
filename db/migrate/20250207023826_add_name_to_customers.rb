class AddNameToCustomers < ActiveRecord::Migration[6.1]
  def change
          ## 名前を保存するカラム
    add_column :customers, :name, :string
  end
end
