class Public::NoticesController < ApplicationController
  before_action :set_group
  before_action :authorize_owner

  def new
    @notice = { title: "", body: "" } # モデルを作らない場合
  end

  def create
    @notice = notice_params # モデルを作らない場合

    if @notice.title.present? && @notice.body.present?
      send_notice_email(@notice)
      redirect_to group_path(@group), notice: "送信が完了しました"
    else
      flash.now[:alert] = "タイトルと本文を入力してください"
      render :new
    end
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def authorize_owner
      redirect_to group_path(@group), alert: "権限がありません" unless @group.owner == current_user
    end

    def notice_params
      params.require(:notice).permit(:title, :body)
    end

    def send_notice_email(notice)
      @group.members.each do |member|
        NoticeMailer.event_notice(member, @group, notice).deliver_later
      end
    end
end
