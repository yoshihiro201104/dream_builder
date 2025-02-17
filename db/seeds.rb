# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 管理者アカウントの作成（Adminテーブルに登録）
Admin.create!(
  email: "admin@admin.com",  # Devise の admin 用ログイン
  password: "aaaaaa",
  password_confirmation: "aaaaaa",
)
