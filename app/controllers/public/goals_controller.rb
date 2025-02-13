class Public::GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    # 現在のログインユーザーのフォームにパラメータを入れる、または、入った状態
    @goal = current_user.goals.new(goal_params)
    # データをデータベースに保存するためのsaveメソッド実行
    if @goal.save
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
    @goal = Goal.find(params[:id])
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = current_user.goals.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_path(@goal), notice: "目標が更新されました！"
    else
      render :edit
    end
  end

  def destroy
    goal = current_user.goals.find(params[:id]) # データ（レコード）を1件取得
    goal.destroy # データ（レコード）を削除
    redirect_to goals_path # 目標一覧画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def goal_params
    params.require(:goal).permit(:goal, :image, :target_date, :monthly_goal_3, :monthly_goal_2, :monthly_goal_1, :weekly_goal, :action,)
  end
end
