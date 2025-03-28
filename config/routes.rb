Rails.application.routes.draw do

  # ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 管理者用のルーティング
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :goals, only: [:index, :show, :edit, :update, :destroy]
    resources :goal_comments, only: [:index, :destroy]
    resources :groups, only: [:index, :show, :destroy]
  end

  # ユーザー用のルーティング
  scope module: :public do
    root "homes#top"
    get "about", to: "homes#about"
    get "/users/check" => "users#check" # 退会確認画面
    patch "/users/withdraw" => "users#withdraw" # 論理削除用のルーティング
    resources :users, only: [:show, :edit, :index, :update] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :goals do
      resources :goal_comments, only: [:create, :destroy]
      resource :like, only: [:create, :destroy]
    end

    resources :dreams, only: [:create, :destroy]
    resources :user_visions

    # 通知機能(更新＝既読状態にする為、updateのみ設定)
    resources :notifications, only: [:update]
    resource :map, only: [:show] # mapのAPI
    resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
      resource :group_users, only: [:create, :update, :destroy] # グループ参加
      resources :events, only: [:new, :create, :show, :edit, :update]  # イベント作成のルーティング
      resource :permits, only: [:create, :destroy] # 参加承認
      member do
        get :permits  # 承認待ち一覧
        patch :approve_group_user  # 承認処理
        patch :reject_group_user  # 参加拒否
        get "notices/new", to: "notices#new"  # お知らせ作成画面
        post "notices", to: "notices#create"  # お知らせ送信処理
      end
    end

  end

  # ゲストサインイン用のルーティング
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # 検索用のルーティング
  get "search" => "searches#search"

  # 開発環境メール送信
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
