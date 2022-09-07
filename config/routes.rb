Rails.application.routes.draw do

  # 顧客用
  # URL /users/sign_in ...
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  scope module: :user do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/my_page' => 'users#show'
    get '/information/edit' => 'users#edit'
    patch '/information' => 'users#update'
    get '/unsubscribe' => 'users#unsubscribe'
    patch '/withdraw' => 'users#withdraw'
  end
  
  get '/books/search' => 'books#search'
  resources :books, only: [:create, :update, :index, :show]
  
  namespace :admin do
  end
end