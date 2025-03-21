class Public::RelationshipsController < ApplicationController
    before_action :authenticate_user!
    def create
      # 今開いているページのuser_idを取得
      user = User.find(params[:user_id])
      # 現在のユーザーがそのページのユーザーをフォロー
      current_user.follow(user)
      redirect_to request.referer
    end
    
    def destroy # ユーザーのフォローを外す
      user = User.find(params[:user_id])
      current_user.unfollow(user)
      redirect_to  request.referer
    end
    
    def followings #そのユーザーがフォローしているユーザーを一覧表示
      user = User.find(params[:user_id])
      @users = user.followings
    end
    
    def followers # そのユーザーをフォローしているユーザーを一覧表示
      user = User.find(params[:user_id])
      @users = user.followers
    end
  end