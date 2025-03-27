class Public::DreamsController < ApplicationController
  # user以外はアクセスできない
    before_action :authenticate_user!

    def create
      @dream = current_user.dreams.build(dream_params)
      if @dream.save
        redirect_to user_path(current_user), notice: "夢を追加しました！"
      else
        redirect_to user_path(current_user), alert: "画像を選択してください。"
      end
    end

    def destroy
      @dream = current_user.dreams.find(params[:id])
      @dream.destroy
      redirect_to user_path(current_user), notice: "夢を削除しました。"
    end

    private
    def dream_params
      params.require(:dream).permit(:image, :description)
    end
end

