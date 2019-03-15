Rails.application.routes.draw do

  root'static_pages#home'
  get '/about', to: "static_pages#about"
  get '/login', to: "sessions#new"
  delete '/logout', to: "sessions#destroy"
  get '/dashboard', to: "users#dashboard"
  patch '/admin/users/:id', to: "admin/users#update"
  get '/categories', to: "categories#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :words, only:[:index]
  end

  resources :sessions, only:[:create]
  resources :relationships, only:[:create,:destroy] do
    resources :activities, only:[:create]
  end
  
  resources :lessons , only:[:show, :create] do
    resources :activities, only:[:crete]
    resources :answers, only:[:new,:create]
  end

  namespace :admin do
    resources :users, only:[:index, :destroy]
    resources :categories do
      resources :words do
        resources :choices 
      end
    end
  end

end
