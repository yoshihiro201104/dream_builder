class GoalComment < ApplicationRecord
  # アソシエーション（関係性）
    # goalはuserに属している
    belongs_to :user
    belongs_to :goal

    # コメントのバリデーション
    validates :comment, presence: true, length: { maximum: 300 }
end
