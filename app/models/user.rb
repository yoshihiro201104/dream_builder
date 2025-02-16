class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true  # 名前が空の場合は登録できない

# アソシエーション（関係性）
  #userはgoalをたくさん持っている 
  has_many :goals, dependent: :destroy
  #userはgoal_commentをたくさん持っている 
  has_many :goal_comments, dependent: :destroy
  
  # ユーザーのプロフィール写真を投稿できるようにする
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
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

end
