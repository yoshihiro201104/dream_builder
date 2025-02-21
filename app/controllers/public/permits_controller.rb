class Public::PermitsController < ApplicationController
  # ログインユーザーなら、以下のアクション実行できる
  before_action :authenticate_user!

  def create
    # 参加するグループIDを取得
    @group = Group.find(params[:group_id])
    # 現在のユーザーのpermitsの箱を作り、その中のgroup_idを取得し、保存
    permit = current_user.permits.new(group_id: params[:group_id])
    permit.save
    # 直前のページにリダイレクト
    redirect_to request.referer, notice: "グループへ参加申請をしました"
  end

  def destroy
    # 現在のユーザーが所属しているグループのpermitsのgroup_idを取得し、削除
    permit = current_user.permits.find_by(group_id: params[:group_id])
    permit.destroy
    redirect_to request.referer, alert: "グループへの参加申請を取消しました"
  end

end
