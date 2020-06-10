Rails.application.routes.draw do

  root to: 'home#top'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :trips, except: [:index] do 
    member do
      resources :schedules, only: [:new, :create, :edit, :update, :destroy]
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end

  resources :relationships, only: [:create, :destroy]

end
