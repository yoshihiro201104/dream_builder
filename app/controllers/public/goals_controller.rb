class Public::GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    # 現在のログインユーザーのフォームにパラメータを入れる、または、入った状態
    goal = current_user.goals.new(goal_params)
    # データをデータベースに保存するためのsaveメソッド実行
    if goal.save
      # トップ画面へリダイレクト
      redirect_to goals_path, notice: "目標が登録されました！"
    else
      render :new
    end

  end

  def index
    @goals = Goal.all
  end

  def show
  end

  def edit
  end

  private
  # ストロングパラメータ
  def goal_params
    params.require(:goal).permit(:goal, :target_date, :monthly_goal_3, :monthly_goal_2, :monthly_goal_1, :weekly_goal, :action,)
  end
end
