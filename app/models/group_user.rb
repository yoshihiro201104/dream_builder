class GroupUser < ApplicationRecord
  # ユーザー：ユーザーグループ＝１：Nの関係
  belongs_to :user
  # グループ：ユーザーグループ＝１：Nの関係
  belongs_to :group
end
