class Public::GroupsController < ApplicationController
  # ユーザー以外がアクセスできないようにする
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :approve]  # approveアクションを追加

  def index
    @goal = Goal.new
    @groups = Group.all
    @user = current_user
  end

  def show
    @goal = Goal.new
    @group = Group.find(params[:id])
    @permits = @group.group_users.where(status: :pending).includes(:user)
  end

  def new
    @group = Group.new
  end

  def create
    # 現在のユーザーがオーナーであるグループを作成
    @group = current_user.owned_groups.new(group_params)
    if @group.save
      # オーナーを自動的にグループに参加 & 承認状態にする
      @group.group_users.create(user: current_user, status: "approved")

      redirect_to @group, notice: "グループを作成しました"
    else
      flash.now[:alert] = "グループ作成に失敗しました: #{@group.errors.full_messages.join(", ")}"
      render :new
    end
  end


  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  # 参加承認待ち一覧
  def permits
    @group = Group.find(params[:id])
    @permits = @group.group_users.where(status: :pending).page(params[:page]).per(10).includes(:user)



  end

  # 承認処理
  def approve_group_user
    @group = Group.find(params[:id])
    permit = @group.group_users.find(params[:permit_id])
    permit.update(status: "approved")

    redirect_to group_path(@group), notice: "ユーザーを承認しました"
  end

    # 参加拒否処理
  def reject_group_user
    @group = Group.find(params[:id])
    permit = @group.group_users.find(params[:permit_id])
    permit.destroy  # 申請データを削除して拒否
    redirect_to group_path(@group), notice: "ユーザーの参加を拒否しました"
  end

  private
  # グループのパラメータを制限
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  # グループオーナーかどうかをチェック
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end



end
