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

    resources :users, only: [:show, :edit, :update] do
      collection do
        get 'check'   # 退会確認ページ
        patch 'withdraw'  # 退会処理
      end
    end

    resources :goals

  end





    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

