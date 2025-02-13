class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]     # 検索モデル→params[:range]
    @word = params[:word]    # 検索ワード→params[:word]

    # もしUserモデルを検索なら、
    if @range == "User"
      # Userモデルの検索方法(完全一致、前方一致、後方一致、部分一致)と検索ワードから検索
      @users = User.looks(params[:search], params[:word])    # 検索方法→params[:search]。looksメソッドを使い、検索内容を取得。
    # もしUserモデルじゃないなら(Goalモデルなら)、
    else
      # Goalモデルの検索方法(完全一致、前方一致、後方一致)と検索ワードから検索
      @goals = Goal.looks(params[:search], params[:word])
    end
  end
end
