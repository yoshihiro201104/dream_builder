Rails.application.routes.draw do
  # 顧客用
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

  scope module: :public do
    root "homes#top"
    get 'about', to: "homes#about"
    # 退会確認画面
    get  '/users/check' => 'users#check'
    # 論理削除用のルーティング
    patch  '/users/withdraw' => 'users#withdraw'
    resources :users, only: [:show, :edit, :update]
    resources :goals




  end





    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

