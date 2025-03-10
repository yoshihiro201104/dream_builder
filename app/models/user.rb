class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 名前のバリデーション(空白禁止、最大50文字)
  validates :name, presence: true, length: { maximum: 50 }
  # メールアドレスのバリデーション(空白禁止、一意性、フォーマット)
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "は正しい形式で入力してください" }

# アソシエーション（関係性）
  #userはgoalをたくさん持っている 
  has_many :goals, dependent: :destroy
  #userはgoal_commentをたくさん持っている 
  has_many :goal_comments, dependent: :destroy
  #userはgroup_usersをたくさん持っている
  has_many :group_users, dependent: :destroy
  #userはdreamをたくさん投稿できる
  has_many :dreams, dependent: :destroy
  
  # ユーザーのプロフィール写真を投稿できるようにする
  has_one_attached :profile_image

  # ユーザーが作成したグループ（オーナーのグループ）
  has_many :owned_groups, class_name: 'Group', foreign_key: 'owner_id', dependent: :destroy


  has_many   :permits,          dependent: :destroy
  has_many   :groups,           through: :group_users


  def get_profile_image(width, height)
    if profile_image.attached? && profile_image.variable?
      profile_image.variant(resize_to_limit: [width, height]).processed
    else
      "/assets/no_image.jpg" # デフォルト画像のパス
    end
  end
  

  # is_active が true のときのみログインを許可する
  def active_for_authentication?
    super && is_active
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match" # 完全一致
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match" # 前方一致
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match" # 後方一致
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match" # 部分一致
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

    # パスワード変更がある場合のみバリデーションを実施
    def password_required?
      new_record? || password.present? || password_confirmation.present?
    end


end
