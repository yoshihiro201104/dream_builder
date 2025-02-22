class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.all # すべてのグループを取得
  end

  def show
    @group = Group.find(params[:id]) # グループの情報を取得
    @group_users = @group.users # グループに所属するユーザーを取得
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_index_path, notice: 'グループを削除しました。'
  end

end
