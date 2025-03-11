class CreateUserVisions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_visions do |t|
      t.string :image
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
