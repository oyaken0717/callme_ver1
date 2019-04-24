Rails.application.routes.draw do
  root to: "homes#top"
  get "/about", to: "homes#about"

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
