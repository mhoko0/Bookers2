Rails.application.routes.draw do
  root to: "homes#top"
  get '/home/about' => "homes#about", as: 'about'
  devise_for :users

  resources :books, only: [:new, :create, :update, :index, :show, :edit, :destroy]
  resources :users, only: [:new, :index, :show, :edit, :update]
end
