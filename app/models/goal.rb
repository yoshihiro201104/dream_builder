class Goal < ApplicationRecord
  # アソシエーション（関係性）
    # goalはuserに属している
    belongs_to :user
end
