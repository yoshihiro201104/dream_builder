class GroupUser < ApplicationRecord
  # ユーザー：ユーザーグループ＝１：Nの関係
  belongs_to :user
  # グループ：ユーザーグループ＝１：Nの関係
  belongs_to :group

  # グループ認証待ち、認証済み、ステータス
  enum status: { pending: 0, approved: 1 }
  # グループ認証待ちのステータス追加
  validates :user_id, uniqueness: { scope: :group_id, message: "はすでに申請済みです" }
end
