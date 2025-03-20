class Public::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_goal

  def create
    like = current_user.likes.build(goal: @goal)
    like.save
    respond_to do |format|
      format.js # create.js.erbを呼び出す
    end
  end

  def destroy
    like = current_user.likes.find_by(goal: @goal)
    like.destroy if like
    respond_to do |format|
      format.js # destroy.js.erbを呼び出す
    end
  end

  private

  def set_goal
    @goal = Goal.find(params[:goal_id])
  end
end
