class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
