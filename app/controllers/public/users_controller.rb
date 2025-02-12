class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @goals = @user.goals
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) # userのパラメーターを保存する
      redirect_to user_path(@user), notice: "プロフィールが更新されました。"
    else
      render :edit, status: :unprocessable_entity
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
    redirect_to new_user_session_path  # ログイン画面へリダイレクト
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email)
  end

end
