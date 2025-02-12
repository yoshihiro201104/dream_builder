class Goal < ApplicationRecord
  # アソシエーション（関係性）
    # goalはuserに属している
    belongs_to :user

    # 画像を投稿できるようにする
    has_one_attached :image

    def get_image
      if image.attached?
        image
      else
        'no_image.jpg'
      end
    end
end
