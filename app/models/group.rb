class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image
  
  # グループに参加。Group モデルが GroupUser モデルを通じて User モデルと関連している
  has_many :users, through: :group_users, source: :user

  # userがグループに所属するか判定
  def includesUser?(user)
    # グループに所属しているユーザーのidと入りたいユーザーのidが一致するか確認。つまり、新規メンバーかどうかを判定。
    group_users.exists?(user_id: user.id)
  end



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
