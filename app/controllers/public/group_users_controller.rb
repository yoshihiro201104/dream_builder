class Public::GroupUsersController < ApplicationController
  # ログインしていないuserはこのコントローラーのアクションを実行できない
  before_action :authenticate_user!
  
  def create
    @group = Group.find(params[:group_id])
    @group_user = @group.group_users.new(user: current_user, status: :pending)

    if @group_user.save
      redirect_to @group, notice: "参加申請を送信しました。承認をお待ちください。"
    else
      redirect_to @group, alert: "参加申請に失敗しました。"
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @group_user = @group.group_users.find(params[:permit_id]) # 承認待ちのユーザーを取得

    if @group_user.update(status: :approved)
      redirect_to permits_group_path(@group), notice: "ユーザーを承認しました。"
    else
      redirect_to permits_group_path(@group), alert: "承認に失敗しました。"
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
