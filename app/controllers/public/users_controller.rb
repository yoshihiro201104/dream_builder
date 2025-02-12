class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    @goals = @user.goals
  end

  def edit
  end

end
