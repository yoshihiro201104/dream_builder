class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# アソシエーション（関係性）
  #userはgoalをたくさん持っている 
  has_many :goals, dependent: :destroy
end
