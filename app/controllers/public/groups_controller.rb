class Public::GroupsController < ApplicationController
    # ユーザー以外がアクセスできないようにする
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
  
    def index
      @goal = Goal.new
      @groups = Group.all
      @user = User.find(current_user.id)
    end
  
    def show
      @goal = Goal.new
      @group = Group.find(params[:id])
      @user = User.find(params[:id])
    end
  
    def new
      @group = Group.new
    end
  
    def create
      @group = Group.new(group_params)
      @group.owner_id = current_user.id
      if @group.save
        redirect_to groups_path, method: :post
      else
        render 'new'
      end
    end
  
    def edit
    end
  
    def update
      if @group.update(group_params)
        redirect_to groups_path
      else
        render "edit"
      end
    end
  
    private
    # 上で使っているgroup_paramsを定義する
    def group_params
      # groupパラメータのname, introduction, group_image,のみ許可する。それ以外は送信できない。
      params.require(:group).permit(:name, :introduction, :group_image)
    end
    # 上で使っている ensure_correct_userを定義する
    def ensure_correct_user
      @group = Group.find(params[:id])
      # もしグループ作成者でないなら、グループ一覧へリダイレクト
      unless @group.owner_id == current_user.id
        redirect_to groups_path
      end
    end
  end
