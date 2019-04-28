Rails.application.routes.draw do
  root to: "homes#top"
  get "/about", to: "homes#about"
  resources :users
  resources :sessions, only: [:new, :create, :show, :destroy]

  resources :conversations do
   resources :messages
  end

  resources :members, only: [:index, :create, :show, :destroy]
  resources :groups do
    resources :posts do
      collection do
        post :confirm
      end
      resources :comments
    end
    resources :favorites, only:[:create, :index, :destroy]
    resources :tags, only: [:create, :destroy]
  end

end
