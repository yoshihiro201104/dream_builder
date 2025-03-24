class Like < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  # 「いいね」と「通知」を紐づける。１つの「いいね」に対して、１回の「通知」（1:1の関係）なので、has_oneを使用
  has_one :notification, as: :notifiable, dependent: :destroy
  # 「いいね」がされると、その投稿者に通知が行く。
  after_create do
    create_notification(user_id: goal.user_id)
  end

  validates :user_id, uniqueness: { scope: :goal_id } # 同じユーザーが同じGoalに複数回いいねできないようにする
  
end
