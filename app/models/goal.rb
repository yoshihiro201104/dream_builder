class Goal < ApplicationRecord
  # アソシエーション（関係性）
    # goalはuserに属している
    belongs_to :user

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
end
