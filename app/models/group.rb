class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image

  has_many :permits, dependent: :destroy

  # ユーザーがグループに所属するか判定
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end

  def is_owned_by?(user)
    owner.id == user.id
  end

  # 検索機能
  def self.looks(search, word)
    case search
    when "perfect_match"
      where("name LIKE ?", word)
    when "forward_match"
      where("name LIKE ?", "#{word}%")
    when "backward_match"
      where("name LIKE ?", "%#{word}")
    when "partial_match"
      where("name LIKE ?", "%#{word}%")
    else
      all
    end
  end
end
