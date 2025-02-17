class Public::UsersController < ApplicationController

  # ログイン前に入れない
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]

  # ゲストユーザーの編集制限
  before_action :ensure_guest_user, only: [:edit, :withdraw, :check]



  def show
    @user = User.find(params[:id])
    @goals = @user.goals
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: "他のユーザーのプロフィールは編集できません"
    end
  end

  def update
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: "他のユーザーのプロフィールは編集できません"
      return
    end
  
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールが更新されました！"
    else
      render :edit
    end
  end
  # 退会確認ページ
  def check
    @user = current_user
  end

  def withdraw
    @user = User.find(current_user.id)
    # is_activeカラムをfalseに変更することにより削除フラグを立てる
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to new_user_registration_path  # 新規登録画面へリダイレクト
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email)
  end

  def ensure_guest_user
    @user = current_user
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  


  
end
