Rails.application.routes.draw do
  # ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  # 管理者用のルーティング
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :goals, only: [:index, :show, :edit, :update, :destroy]
  end

  # ユーザー用のルーティング
  scope module: :public do
    root "homes#top"
    get 'about', to: "homes#about"
    get '/users/check' => 'users#check' # 退会確認画面
    patch '/users/withdraw' => 'users#withdraw' # 論理削除用のルーティング
    resources :users, only: [:show, :edit, :index, :update]
    resources :goals do
      resources :goal_comments, only: [:create, :destroy]
    end
    resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
      resource :group_users, only: [:create, :update, :destroy] # グループ参加の為のルーティング
      resource :permits, only: [:create, :destroy] # 参加承認する為のルーティング
      member do
        get :permits  # 承認待ち一覧表示のパス
        patch :approve_group_user  # 承認処理用のパス
        patch :reject_group_user  # 参加拒否用のパス
      end
    end
  end

  # ゲストサインイン用のルーティング
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # 検索用のルーティング
  get "search" => "searches#search"
end
