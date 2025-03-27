class Public::UserVisionsController < ApplicationController
  before_action :set_user_vision, only: [:show, :edit, :update, :destroy]

  def index
    @user_visions = UserVision.all
  end

  def show
  end

  def new
    @user_vision = UserVision.new
  end

  def create
    @user_vision = UserVision.new(user_vision_params)
    @user_vision.user = current_user # ログイン機能がある場合

    if @user_vision.save
      redirect_to [:public, @user_vision], notice: "ビジョンが作成されました！"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user_vision.update(user_vision_params)
      redirect_to [:public, @user_vision], notice: "ビジョンが更新されました！"
    else
      render :edit
    end
  end

  def destroy
    @user_vision.destroy
    redirect_to public_user_visions_path, notice: "ビジョンが削除されました！"
  end

  private
    def set_user_vision
      @user_vision = UserVision.find(params[:id])
    end

    def user_vision_params
      params.require(:user_vision).permit(:image, :description)
    end
end
