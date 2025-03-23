class Goal < ApplicationRecord
  # アソシエーション（関係性）
    # goalはuserに属している
    belongs_to :user
    #goalはgoal_commentをたくさん持っている 
    has_many :goal_comments, dependent: :destroy

    # goal投稿すると、通知されるようにnotificationsに紐づける
    has_many :notifications, as: :notifiable, dependent: :destroy
    # コールバックでユーザーのフォロー人がgoalを作ると、処理される
    after_create do
      user.followers.each do |follower|
        notifications.create(user_id: follower.id)
      end
    end  

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    # AI画像認識
    has_many :tags, dependent: :destroy

    # 画像を投稿できるようにする
    has_one_attached :image

    # バリデーションの追加し、エラーメッセージが表示できるようにする
    validates :goal, presence: true
    validates :target_date, presence: true
    validates :action, presence: true

    def get_image
      if image.attached?
        image
      else
        'no_image.jpg'
      end
    end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match" # 完全一致
      @goal = Goal.where("goal LIKE?","#{word}")
    elsif search == "forward_match" # 前方一致
      @goal = Goal.where("goal LIKE?","#{word}%")
    elsif search == "backward_match" # 後方一致
      @goal = Goal.where("goal LIKE?","%#{word}")
    elsif search == "partial_match" # 部分一致
      @goal = Goal.where("goal LIKE?","%#{word}%")
    else
      @goal = Goal.all
    end
  end

end
