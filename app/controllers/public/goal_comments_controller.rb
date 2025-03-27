class Public::GoalCommentsController < ApplicationController
  # ログインユーザーのみコメント可能
  before_action :authenticate_user!

  def create
    @goal = Goal.find(params[:goal_id])
    @goal_comment = @goal.goal_comments.new(comment_params)
    @goal_comment.user = current_user

    if @goal_comment.save
      redirect_to request.referer, notice: "コメントを投稿しました。" # request.referer:直前のページに戻る
    else
      redirect_to request.referer, alert: "コメントの投稿に失敗しました。"
    end
  end

  def destroy
    @goal_comment = GoalComment.find(params[:id])

    if @goal_comment.user == current_user # 自分のコメントのみ削除可能
      @goal_comment.destroy
      redirect_to request.referer, notice: "コメントを削除しました。"
    else
      redirect_to request.referer, alert: "削除権限がありません。"
    end
  end

  private
    def comment_params
      params.require(:goal_comment).permit(:comment)
    end
end
