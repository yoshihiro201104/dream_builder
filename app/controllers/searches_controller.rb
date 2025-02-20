class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]     # 検索モデル→params[:range]
    @word = params[:word]    # 検索ワード→params[:word]

    case @range
    # もしUserモデルを検索なら、
    when "User" 
      # Userモデルの検索方法(完全一致、前方一致、後方一致、部分一致)と検索ワードから検索
      @users = User.looks(params[:search], @word)    # 検索方法→params[:search]。looksメソッドを使い、検索内容を取得。
    # もしUserモデルじゃないなら(Goalモデルなら)、
    when "Goal"
      # Goalモデルの検索方法(完全一致、前方一致、後方一致)と検索ワードから検索
      @goals = Goal.looks(params[:search], @word)
    when "Group"
      @groups = Group.looks(params[:search], @word)
    end
  end
end
