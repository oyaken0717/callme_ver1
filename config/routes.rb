Rails.application.routes.draw do
  root to: "homes#top"
  get "/about", to: "homes#about"
  resources :sessions, only: [:new, :create, :show, :destroy]

  resources :groups do
    resources :posts do
      collection do
        post :confirm
      end
      # resources :comments
    end
  end
  resources :users
end
