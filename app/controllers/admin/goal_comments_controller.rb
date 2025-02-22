class Admin::GoalCommentsController < ApplicationController
  before_action :authenticate_admin! # 管理者のみ実行できる

  # コメントをすべて取得
  def index
    @goal_comments = GoalComment.all
  end

  def destroy
    # 表示しているページのコメントIDを取得
    @comment = GoalComment.find(params[:id])
    # 取得したコメントIDを削除
    @comment.destroy
    # コメント一覧へリダイレクトし、削除メッセージ表示
    redirect_to admin_goal_comments_path, notice: 'コメントを削除しました'
  end

end
