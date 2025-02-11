class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :goal, null: false
      t.date :target_date, null: false
      t.string :monthly_goal_3, null: false
      t.string :monthly_goal_2, null: false
      t.string :monthly_goal_1, null: false
      t.string :weekly_goal, null: false
      t.text :action, null: false

      t.timestamps
    end
  end
end
