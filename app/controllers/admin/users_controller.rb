class Admin::UsersController < ApplicationController
  # 管理者のみログイン
  before_action :authenticate_admin!
  
      # 全ユーザーを一覧表示
      def index
        @users = User.all
      end
  
      # 特定のユーザーの詳細ページ
      def show
        @user = User.find(params[:id])
      end
  
      # ユーザー情報を編集する画面
      def edit
        @user = User.find(params[:id])
      end
  
      # ユーザー情報を更新する処理
      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to admin_user_path(@user), notice: 'ユーザー情報を更新しました'
        else
          render :edit
        end
      end
  
      # ユーザーを削除する処理
      def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_users_path, notice: 'ユーザーを削除しました'
      end
  
      private
  
      # 更新時に許可するパラメータを設定
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_active)
      end
    end
