class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image
  
  def is_owned_by?(user)
    owner.id == user.id
  end

  # 検索機能を追加
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
