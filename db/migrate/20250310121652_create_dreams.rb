class CreateDreams < ActiveRecord::Migration[6.1]
  def change
    create_table :dreams do |t|
      t.references :user, null: false, foreign_key: true
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
