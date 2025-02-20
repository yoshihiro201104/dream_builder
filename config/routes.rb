Rails.application.routes.draw do

  # ユーザー用
# URL /customers/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions'
  }

  #管理者用のルーティング
  namespace :admin do # namespaceを使うことで、URLにadmin/を追加し、ユーザー側と分けている
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :goals, only: [:index, :show, :edit, :update, :destroy]
  end

  # ユーザー用のルーティング
  scope module: :public do
    root "homes#top"
    get 'about', to: "homes#about"
    get  '/users/check' => 'users#check' # 退会確認画面
    patch  '/users/withdraw' => 'users#withdraw' # 論理削除用のルーティング
    resources :users, only: [:show, :edit, :index, :update]
    resources :goals do
      resources :goal_comments, only: [:create, :destroy]
    end
    resources :groups, only: [:new, :index, :show, :create, :edit, :update] #グループのルーティング
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # 検索のルーティング
  get "search" => "searches#search"

    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

