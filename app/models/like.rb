class Like < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :user_id, uniqueness: { scope: :goal_id } # 同じユーザーが同じGoalに複数回いいねできないようにする
  
end
