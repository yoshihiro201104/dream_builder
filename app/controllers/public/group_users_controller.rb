class Public::GroupUsersController < ApplicationController
  # ログインしていないuserはこのコントローラーのアクションを実行できない
  before_action :authenticate_user!
  
  def create
    # 現在のユーザーをグループユーザーに追加。その際、group_idを付与している。
    group_user = current_user.group_users.new(group_id: params[:group_id])
    # 保存し、
    group_user.save
    # 直前のページへリダイレクト
    redirect_to request.referer
  end
  
  def destroy 
    # 現在のユーザーをグループから削除。find_byを使い、ユーザーのgroup_idを探す。
    # もしfindを使うと、idがない時、エラーになる。find_byなら、エラーにならず、nillを返してくれる。
    # 現在のユーザー、かつそのユーザーの所属しているグループのgroup_idを探す
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    redirect_to request.referer
  end
end
