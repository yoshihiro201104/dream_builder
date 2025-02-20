class Public::GroupsController < ApplicationController
  # ユーザー以外がアクセスできないようにする
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @goal = Goal.new
    @groups = Group.all
    @user = current_user
  end

  def show
    @goal = Goal.new
    @group = Group.find(params[:id])
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
