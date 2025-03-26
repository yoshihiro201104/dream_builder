class Public::GoalsController < ApplicationController
  # 非ログイン時なら、中のページが見れない
  before_action :authenticate_user!, only: [:new, :show, :edit, :update, :destroy]

  def new
    @goal = Goal.new
  end

  def create
    # 現在のログインユーザーのフォームにパラメータを入れる、または、入った状態
    @goal = current_user.goals.new(goal_params)

    # 画像がアップロードされている場合のみAIに渡す
    if goal_params[:image].present?
      tags = Vision.get_image_data(goal_params[:image])
    else
      tags = []
    end

    # データをデータベースに保存するためのsaveメソッド実行
    if @goal.save
      tags.each do |tag|
        @goal.tags.create(name: tag)
      end
      # トップ画面へリダイレクト
      redirect_to goal_path(@goal), notice: "目標が登録されました！"
    else
      render :new
    end
  end

  def index
    @goals = Goal.all
  end

  def show
    @goal = Goal.find_by(id: params[:id])
    # もし目標idがなければ、一覧画面へリダイレクト
    if @goal.nil?
      redirect_to goals_path, alert: "目標が見つかりません"
    end
  end

  def edit
    # 現在のユーザーの目標をすべて取得し、その中に、paramsで指定されたidがあるか確認している
    @goal = current_user.goals.find_by(id: params[:id]) # 現在のユーザーの目標のみ取得
    if @goal.nil?
      redirect_to goals_path, alert: "この目標の編集は許可されていません"
    end
  end

  def update
    @goal = current_user.goals.find(params[:id]) #現在のユーザーの目標IDと指定されたIDが一致しているのか確認
    if @goal.nil?
      redirect_to goals_path, alert: "この目標の更新は許可されていません"
      return
    end

    if @goal.update(goal_params)
      redirect_to goal_path(@goal), notice: "目標が更新されました！"
    else
      render :edit
    end
  end

  def destroy
    goal = current_user.goals.find(params[:id]) # データ（レコード）を1件取得
    goal.destroy # データ（レコード）を削除
    redirect_to user_path(current_user) # マイページへリダイレクト
  end

  private
    # ストロングパラメータ
    def goal_params
      params.require(:goal).permit(:goal, :image, :target_date, :monthly_goal_3, :monthly_goal_2, :monthly_goal_1, :weekly_goal, :action,)
    end
end
