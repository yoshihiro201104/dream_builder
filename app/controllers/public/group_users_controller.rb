class Public::GroupUsersController < ApplicationController
  # ログインしていないuserはこのコントローラーのアクションを実行できない
  before_action :authenticate_user!
  
  def create
    # 現在のユーザーをグループユーザーとして申請（pending状態）
    group_user = current_user.group_users.new(group_id: params[:group_id], status: :pending)
    if group_user.save
      redirect_to request.referer, notice: '参加申請を送信しました'
    else
      redirect_to request.referer, alert: 'すでに申請済みです'
    end
  end

  # オーナーが承認するとステータスをapprovedに変更
  def update
    # 参加申請していユーザーのidをgroup_userとする
    group_user = GroupUser.find(params[:id])
    # ステータスをspprovedにアップデートできたら、参加承認
    if group_user.update(status: :approved)
      redirect_to request.referer, notice: '参加を承認しました'
    else
      # 参加を拒否したら、直前のページに戻す
      redirect_to request.referer, alert: '承認に失敗しました'
    end
  end


  # オーナーが拒否、またはメンバーが脱退する場合
  def destroy
    # 現在のユーザーかつグループユーザーに登録されているgroup_idを探索
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    # もしヒットしたら、そのidを削除して、直前のページにリダイレクト
    if group_user
      group_user.destroy
      redirect_to request.referer, notice: 'グループから退出しました'
    else
      # なければ、エラーメッセージを表示して、直前のページにリダイレクト
      redirect_to request.referer, alert: '操作に失敗しました'
    end
  end


end
