Rails.application.routes.draw do
  scope module: :public do
    root "homes#top"
    get 'about', to: "homes#about"
  end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
