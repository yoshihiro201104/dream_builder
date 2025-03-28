class Public::HomesController < ApplicationController
  def top
    @group = Group.first # 仮に最初のグループを取得
  end
  

  def about
  end
end
