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
      # オーナーを自動的にグループに参加させる
      @group.group_users.create(user: current_user)
      redirect_to @group, notice: 'グループを作成しました'
    else
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
    @permit = @group.group_users.find(params[:group_user_id]) # 承認する申請者を取得
  
    if @group.is_owned_by?(current_user) # オーナーであることを確認
      @permit.update(status: :approved)  # 承認処理
      redirect_to permits_group_path(@group), notice: '申請者を承認しました'
    else
      redirect_to @group, alert: '承認する権限がありません'
    end
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
