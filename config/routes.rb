Rails.application.routes.draw do

  # 顧客用
  # URL /users/sign_in ...
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in' => 'user/sessions#guest_sign_in'
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  
  scope module: :user do
    resources :notifications, only: :index do
      delete 'notifications/destroy_all' => 'notifications#destroy_all'
    end
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/my_page/:id' => 'users#show', as: :my_page
    get '/information/edit' => 'users#edit'
    patch '/information' => 'users#update'
    get '/unsubscribe' => 'users#unsubscribe'
    patch '/withdraw' => 'users#withdraw'
    
    resources :reviews, only:[:index]
  end
  
  get '/books/search' => 'books#search'
  resources :books, only: [:new, :create, :update, :index, :show, :edit, :update, :destroy] do
    resources :reviews, only: [:new, :create, :show, :edit, :update, :destroy], module: :user do
      resource :favorites, only: [:create, :destroy]
      get 'favorites' => 'reviews#favorites', as: "review_favorites"
      resources :review_comments, only: [:create, :destroy]
    end
  end
  
  
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
  end
end