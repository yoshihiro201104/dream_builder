class Admin::GoalsController < ApplicationController
  def index
    @goals = Goal.all
  end

  def show
    @goal = Goal.find_by(id: params[:id])

    # もし目標idがなければ、一覧画面へリダイレクト
    if @goal.nil?
      redirect_to admin_goals_path, alert: "目標が見つかりません"
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id]) # ここも抜けていたので追加
    if @goal.update(goal_params)
      redirect_to admin_goal_path(@goal), notice: "目標が更新されました！"
    else
      render :edit
    end
  end

  def destroy
    goal = Goal.find(params[:id])  # `goals.find` → `Goal.find` に修正
    goal.destroy # データ（レコード）を削除
    redirect_to admin_goals_path, notice: "目標が削除されました"
  end

  private
    # ストロングパラメータ
    def goal_params
      params.require(:goal).permit(:goal, :image, :target_date, :monthly_goal_3, :monthly_goal_2, :monthly_goal_1, :weekly_goal, :action)
    end
end
